class EbayAPI
  #
  # eBay Commerce APIs
  #
  # @see https://developer.ebay.com/api-docs/commerce/static/commerce-landing.html
  #
  scope :commerce do
    path "commerce"

    require_relative "commerce/notification"
    require_relative "commerce/taxonomy"
    require_relative "commerce/media"
  end
end
