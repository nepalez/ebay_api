require_relative "./bid_percentage"

class EbayAPI
  # Defines how the Promoted Listing fee is calculated.
  #
  # @see https://developer.ebay.com/api-docs/sell/marketing/types/pls:FundingStrategy
  class FundingStrategy < Evil::Client::Model
    option :bidPercentage,
           type: BidPercentage,
           as: :bid_percentage,
           desc: "Fee to the percentage of the sale price of the listing"
    option :fundingModel,
           as: :funding_model,
           default: proc { "COST_PER_SALE" },
           desc: "Model that eBay uses to calculate the Promoted Listings fee"

    FUNDING_MODELS = %w[COST_PER_SALE].freeze

    validate do
      unless FUNDING_MODELS.include?(funding_model)
        errors.add :unsupported_funding_model, model: funding_model
      end
    end

    def self.call(raw)
      raw && new(raw)
    end

    def to_h
      {
        bidPercentage: bid_percentage,
        fundingModel:  funding_model
      }
    end
  end
end
