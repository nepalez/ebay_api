class EbayAPI
  scope :commerce do
    #
    # eBay Commerce Notifications API
    #
    # @see https://developer.ebay.com/api-docs/commerce/notification/overview.html
    #
    scope :notifications do
      path { "notifications/v#{EbayAPI::COMMERCE_NOTIFICATIONS_VERSION[/^\d+/]}" }

      require_relative "notifications/public_key"
    end
  end
end
