class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/ad/methods/getAd
        operation :get do
          http_method :get
          path { "ad/#{ad_id}" }

          option :ad_id
        end
      end
    end
  end
end
