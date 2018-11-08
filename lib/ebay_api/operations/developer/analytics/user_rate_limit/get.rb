class EbayAPI
  scope :developer do
    scope :analytics do
      scope :user_rate_limit do
        # @see https://developer.ebay.com/api-docs/developer/analytics/resources/user_rate_limit/methods/getUserRateLimits
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
