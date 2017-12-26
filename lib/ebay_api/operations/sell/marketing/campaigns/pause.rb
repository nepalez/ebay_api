class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/campaign/methods/pauseCampaign
        operation :pause do
          http_method :post
          path { "#{campaign_id}/pause" }

          option :campaign_id

          response(204) { true }
        end
      end
    end
  end
end
