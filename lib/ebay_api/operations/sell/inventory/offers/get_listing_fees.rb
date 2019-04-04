class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        # https://developer.ebay.com/api-docs/sell/inventory/resources/offer/methods/getListingFees
        operation :get_listing_fees do
          option :offer_ids,
                 ->(ids) { Array(ids).map { |id| { offerId: id.to_s } } },
                 as: :offers

          validate { errors.add :no_data        if offers.empty? }
          validate { errors.add :limit_exceeded if offers.size > 250 }

          http_method :post
          path "get_listing_fees"
          body { { offers: offers } }
        end
      end
    end
  end
end
