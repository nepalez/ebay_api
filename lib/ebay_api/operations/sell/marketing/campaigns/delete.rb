class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/campaign/methods/deleteCampaign
        operation :delete do
          http_method :delete
          path { campaign_id }

          option :campaign_id

          response(204) { true }
        end
      end
    end
  end
end
