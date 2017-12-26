# Parses API response as JSON
class EbayAPI
  class PaginatedCollection
    class MiddlewareBuilder
      class << self
        def call(max_limit: 500)
          Class.new(Middleware).tap do |middleware|
            middleware.send(:define_method, :max_limit) { max_limit }
          end
        end
      end
    end

    class Middleware
      def initialize(app)
        @app = app
      end

      def max_limit
        raise NotImplementedError, <<~MSG.tr("\n", " ")
          You can't use #{self.class} directly.
          Use it with EbayAPI::PaginatedCollection::MiddlewareBuilder.call!
        MSG
      end

      def call(env)
        query = Rack::Utils.parse_nested_query(env["QUERY_STRING"])
        query["limit"] = [query["limit"].to_i, max_limit].min if query["limit"]
        env["QUERY_STRING"] = Rack::Utils.build_nested_query(query)
        @app.call(env)
      end
    end
  end
end
