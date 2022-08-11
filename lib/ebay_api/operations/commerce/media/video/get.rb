class EbayAPI
  scope :commerce do
    scope :media do
      scope :video do
        # @see https://developer.ebay.com/api-docs/commerce/media/resources/video/methods/getVideo
        operation :get do
          option :id, proc(&:to_s)

          path { id }
          http_method :get
        end
      end
    end
  end
end
