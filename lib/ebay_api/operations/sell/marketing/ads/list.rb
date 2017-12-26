class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/ad/methods/getAds
        operation :list do
          http_method :get
          path "ad"

          option :limit,  optional: true
          option :offset, optional: true

          query { { limit: limit, offset: offset }.compact }

          middleware { PaginatedCollection::MiddlewareBuilder.call }

          response(200) do |*response|
            PaginatedCollection.new(self, response, "ads")
          end

          response(404) do |_, _, (data, *)|
            code = data.dig("errors", 0, "errorId")
            raise Error.new(code: code), data.dig("errors", 0, "message")
          end
        end
      end
    end
  end
end
