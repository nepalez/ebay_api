class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/ad/methods/bulkDeleteAdsByListingId
        operation :bulk_delete_by_listing_id do
          http_method :post
          path "bulk_delete_ads_by_listing_id"

          option :listing_ids

          body do
            {
                requests: listing_ids.map do |listing_id|
                  {
                      listingId: listing_id
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
