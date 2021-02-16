# frozen_string_literal: true

#
class EbayAPI
  class PaginatedCollection
    class Request < Evil::Client::Resolver::Request
      def initialize(schema, settings, uri:, limit: nil)
        super(schema, settings)
        @uri = URI(uri)
        @limit = limit
      end

      def environment
        super.merge!("QUERY_STRING" => paginated_query)
      end

      private

      def paginated_query
        return @uri.query unless @limit
        q = Rack::Utils.parse_nested_query(@uri.query)
        q["limit"] = [q["limit"]&.to_i, @limit].compact.min
        Rack::Utils.build_nested_query(q)
      end
    end

    include Enumerable

    attr_reader :size

    def initialize(handler, response, key)
      @schema             = handler.instance_variable_get(:@__schema__)
      @settings           = handler.instance_variable_get(:@__settings__)
      @expected_status    = handler.instance_variable_get(:@__keys__).last
      @key                = key
      @initial_collection = handle_response(*response)
      @records_left       = @settings.limit
      @initial_next       = @next
    end

    def each(&block)
      return to_enum unless block
      @collection = @initial_collection
      @next       = @initial_next
      loop do
        @collection.each { |element| block.call(element) }
        raise StopIteration if all_records_loaded?
        load_next!
      end
    end

    private

    def all_records_loaded?
      return true unless @next
      @records_left && (@records_left -= @collection.size).zero?
    end

    def load_next!
      request = Request.call @schema, @settings,
                             uri: @next, limit: @records_left
      middleware = Evil::Client::Resolver::Middleware.call(@schema, @settings)
      connection = @schema.client.connection
      stack      = middleware.inject(connection) { |app, layer| layer.new app }
      handle_response(*stack.call(request))
    end

    def handle_response(status, _headers, (data, *))
      raise EbayAPI::Error unless status == @expected_status
      @next = data["next"]
      @size = data["total"]
      @collection = data[@key]
    end
  end
end
