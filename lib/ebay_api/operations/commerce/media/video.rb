class EbayAPI
  scope :commerce do
    #
    # eBay Commerce Media API
    #
    # @see https://developer.ebay.com/api-docs/commerce/media/overview.html
    #
    scope :media do
      scope :video do
        path "video"

        require_relative "video/get"
        require_relative "video/create"
        require_relative "video/upload"
      end
    end
  end
end
