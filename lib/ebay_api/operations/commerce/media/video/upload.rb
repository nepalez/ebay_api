class EbayAPI
  scope :commerce do
    scope :media do
      scope :video do
        # @see https://developer.ebay.com/api-docs/commerce/media/resources/video/methods/uploadVideo
        operation :upload do
          option :id, proc(&:to_s)
          option :file

          path { "#{id}/upload" }
          http_method :post
          # Upload endpoint of Ebay Media API requires "content-type": "application/octet-stream"
          #   request header.
          #   But evil-client hasn't format for "application/octet-stream".
          #   That's we using "text" format and changing "content-type" header
          #   in ReplaceRequestHeaders middleware.
          format { :text }
          body   { file }
        end
      end
    end
  end
end
