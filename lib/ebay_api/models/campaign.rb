require_relative "./funding_strategy"
require_relative "./timestamp"

class EbayAPI
  # The promotional campaign - container for promoted listings.
  #
  # @see https://developer.ebay.com/api-docs/sell/marketing/types/pls:CreateCampaignRequest
  class Campaign < Evil::Client::Model
    option :campaignId,
           as: :campaign_id,
           optional: true,
           desc: ""
    option :campaignName,
           as: :campaign_name
    option :fundingStrategy,
           type: FundingStrategy,
           as: :funding_strategy,
           desc: ""
    option :startDate,
           type: Timestamp,
           as: :start_date,
           desc: ""
    option :endDate,
           type: Timestamp,
           as: :end_date,
           optional: true,
           desc: ""
    option :marketplaceId,
           as: :marketplace_id
    option :campaignCriterion,
           as: :campaign_criterion,
           optional: true

    MARKETPLACES = %w[EBAY_US EBAY_GB EBAY_DE EBAY_AU].freeze

    validate do
      unless MARKETPLACES.include?(marketplace_id)
        errors.add :unsupported_marketplace, site: marketplace_id
      end
    end

    def self.call(raw)
      raw && new(raw)
    end

    def to_h
      {
        campaignId:        campaign_id,
        campaignName:      campaign_name,
        fundingStrategy:   funding_strategy&.to_h,
        startDate:         start_date,
        endDate:           end_date,
        marketplaceId:     marketplace_id,
        campaignCriterion: campaign_criterion&.to_h
      }.reject { |_, value| value.nil? }
    end
  end
end
