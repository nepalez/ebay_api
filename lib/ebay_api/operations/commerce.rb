class EbayAPI
  #
  # eBay Commerce APIs
  #
  # @see https://developer.ebay.com/api-docs/commerce/static/commerce-landing.html
  #
  scope :commerce do
    path "commerce"

    require_relative "commerce/notifications"
  end
end
