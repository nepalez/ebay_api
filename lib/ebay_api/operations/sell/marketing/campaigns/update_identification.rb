class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/campaign/methods/updateCampaignIdentification
        operation :update_identification do
          http_method :post
          path { "#{campaign_id}/update_campaign_identification" }

          option :campaign_id
          option :campaign_name
          option :start_date
          option :end_date,     optional: true

          body do
            mapping = {
                campaignName: :campaign_name,
                endDate: :end_date,
                startDate: :start_date
            }.select do |_, option_name|
              options.key?(option_name)
            end
            Hash[mapping.map { |k, v| [k, options[v]] }]
          end

          response(204) { true }
        end
      end
    end
  end
end
