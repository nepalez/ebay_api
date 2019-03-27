require_relative "../../../../paginated_collection"

class EbayAPI
  scope :sell do
    scope :inventory do
      scope :inventory_items do
        operation :list do
          option :limit,  optional: true
          option :offset, optional: true

          http_method :get

          query do
            { limit: limit, offset: offset }.compact
          end

          middleware { PaginatedCollection::MiddlewareBuilder.call }

          response(200) do |*response|
            PaginatedCollection.new(self, response, "inventoryItems")
          end
        end
      end
    end
  end
end
