class EbayAPI
  scope :commerce do
    scope :media do
      scope :video do
        # @see https://developer.ebay.com/api-docs/commerce/media/resources/video/methods/createVideo
        operation :create do
          option :payload, proc(&:to_h) # TODO: add model to validate input

          # Create endpoint of Ebay Media API return empty body by it self and id
          #   of created video is located in location response header.
          #   We uses AddVideoIdToBody middleware for putting id to body
          path { "/" }
          http_method :post
          body { payload.merge("classification" => ["ITEM"]) }
        end
      end
    end
  end
end
