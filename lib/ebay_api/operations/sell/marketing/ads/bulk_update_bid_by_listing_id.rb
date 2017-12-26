require "ebay_api/models/bid_percentage"

class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/ad/methods/bulkUpdateAdsBidByListingId
        operation :bulk_update_bid_by_listing_id do
          http_method :post
          path "bulk_update_ads_bid_by_listing_id"

          option :ad_requests

          body do
            {
                requests: ad_requests.map do |ad|
                  {
                      listingId: ad[:listing_id],
                      bidPercentage: BidPercentage.call(ad[:bid])
                  }
                end
            }
          end

          response(200, 207) do |_, _, (data, *)|
            data["responses"]
          end
        end
      end
    end
  end
end
