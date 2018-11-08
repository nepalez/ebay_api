class EbayAPI
  scope :developer do
    #
    # eBay Developer Analytics API
    #
    # @see https://developer.ebay.com/api-docs/developer/analytics/static/overview.html
    #
    scope :analytics do
      path { "analytics/v#{EbayAPI::DEVELOPER_ANALYTICS_VERSION[/^\d[\w]+/]}" }

      require_relative "analytics/rate_limit"
      require_relative "analytics/user_rate_limit"
    end
  end
end
