#
# Offers-related operations of the inventory API
#
class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        path "offer"

        # https://developer.ebay.com/api-docs/sell/inventory/resources/offer/methods/getListingFees
        operation :get_listing_fees do
          option :offer_ids,
                 ->(ids) { Array(ids).map(&:to_s).reject(&:empty?).uniq }

          validate { errors.add :no_data        if offers.empty? }
          validate { errors.add :limit_exceeded if offers.size > 250 }

          http_method :post
          path "get_listing_fees"
          body { { offers: offer_ids.map { |id| { offerId: id } } } }
          response(200) { |_, _, body| JSON.parse(body.first) }
        end
      end
    end
  end
end
