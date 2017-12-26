class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/campaign/methods/getCampaign
        operation :get do
          http_method :get
          path { campaign_id }

          option :campaign_id

          response(200) { |_, _, (data, *)| data }
        end
      end
    end
  end
end
