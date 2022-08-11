class EbayAPI
  scope :commerce do
    #
    # eBay Commerce Media API
    #
    # @see https://developer.ebay.com/api-docs/commerce/media/overview.html
    #
    scope :media do
      path { "media/v#{EbayAPI::COMMERCE_MEDIA_VERSION.split('.')[0]}" }

      require_relative "media/video"
    end
  end
end
