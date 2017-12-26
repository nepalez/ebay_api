require "ebay_api/models/bid_percentage"

class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/ad/methods/updateBid
        operation :update_bid do
          http_method :post
          path { "ad/#{ad_id}/update_bid" }

          option :ad_id
          option :bid_percentage, BidPercentage

          body do
            { bidPercentage: bid_percentage }
          end

          response(204) { true }
        end
      end
    end
  end
end
