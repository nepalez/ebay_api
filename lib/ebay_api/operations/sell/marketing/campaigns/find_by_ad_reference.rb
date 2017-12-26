class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/campaign/methods/findCampaignByAdReference
        operation :find_by_ad_reference do
          http_method :get
          path :find_campaign_by_ad_reference

          option :inventory_reference_type, optional: true
          option :inventory_reference_id,   optional: true
          option :listing_id,               optional: true

          query { options.compact }

          response(200) { |_, _, (data, *)| data["campaigns"] }
        end
      end
    end
  end
end
