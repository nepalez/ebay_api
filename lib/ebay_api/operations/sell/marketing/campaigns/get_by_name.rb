class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/campaign/methods/getCampaignByName
        operation :get_by_name do
          http_method :get
          path { :get_campaign_by_name }

          query { { campaign_name: campaign_name } }

          option :campaign_name

          response(200) { |_, _, (data, *)| data }
          response(404) { nil }
        end
      end
    end
  end
end
