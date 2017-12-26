class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/ad/methods/bulkCreateAdsByListingId
        operation :bulk_create_by_listing_id do
          http_method :post
          path "bulk_create_ads_by_listing_id"

          option :ad_requests

          # TODO: Max 500 ads per call

          body do
            {
                requests: ad_requests.map do |ad_request|
                  {
                      listingId:     ad_request[:listing_id],
                      bidPercentage: ad_request[:bid],
                  }
                end
            }
          end

          response(200, 207) { |_, _, (data, *)| data["responses"] }
        end
      end
    end
  end
end
