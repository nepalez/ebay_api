require_relative "../../../../paginated_collection"

class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/campaign/methods/getCampaigns
        operation :list do
          http_method :get

          option :limit,  optional: true
          option :offset, optional: true

          query { { limit: limit, offset: offset }.compact }

          middleware { PaginatedCollection::MiddlewareBuilder.call }

          response(200) do |*response|
            PaginatedCollection.new(self, response, "campaigns")
          end
        end
      end
    end
  end
end
