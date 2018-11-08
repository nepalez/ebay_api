class EbayAPI
  scope :developer do
    scope :analytics do
      scope :rate_limit do
        # @see https://developer.ebay.com/api-docs/developer/analytics/resources/rate_limit/methods/getRateLimits
        operation :get do
          http_method :get
          path { "/" }

          response(200) do |_, _, (data, *)|
            data["rateLimits"]
          end
        end
      end
    end
  end
end
