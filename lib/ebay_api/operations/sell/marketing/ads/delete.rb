class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/ad/methods/deleteAd
        operation :delete do
          http_method :delete
          path { "ad/#{ad_id}" }

          option :ad_id

          response(204) { true }
        end
      end
    end
  end
end
