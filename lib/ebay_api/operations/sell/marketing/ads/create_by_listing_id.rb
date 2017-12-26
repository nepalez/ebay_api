require "ebay_api/models/bid_percentage"

class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/ad/methods/createAdByListingId
        operation :create_by_listing_id do
          http_method :post
          path "ad"

          option :listing_id
          option :bid_percentage, BidPercentage

          body do
            { listingId: listing_id, bidPercentage: bid_percentage }
          end

          response(201) do |_, headers, _|
            headers["location"].first
          end
        end
      end
    end
  end
end
