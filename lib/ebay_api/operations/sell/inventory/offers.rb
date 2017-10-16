#
# Offers-related operations of the inventory API
#
class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        path "offer"

        operation :create_offer do
          http_method :post

        end

        operation :update_offer do
          http_method :put
        end

        operation :get_offers do
          option :sku
          option :limit,  optional: true
          option :offset, optional: true

          http_method :get
          query do
            { sku: sku, limit: limit, offset: offset }.select { |_, v| v }
          end
        end

        operation :get_offer do
          option :offer_id

          http_method :get
          path        { offer_id.to_s }
        end

        operation :delete_offer do
          option :offer_id

          http_method :delete
          path        { "#{offer_id}/delete" }
        end

        operation :publish_offer do
          option :offer_id

          http_method :post
          path        { "#{offer_id}/publish" }
        end

        # https://developer.ebay.com/api-docs/sell/inventory/resources/offer/methods/getListingFees
        operation :get_listing_fees do
          option :offer_ids,
                 ->(ids) { Array(ids).map { |id| { offerId: id.to_s } } },
                 as: :offers

          validate { errors.add :no_data        if offers.empty? }
          validate { errors.add :limit_exceeded if offers.size > 250 }

          http_method :post
          path        "get_listing_fees"
          body        { { offers: offers } }
        end

        operation :withdraw_offer do
          option :offer_id

          http_method :post
          path        { "#{offer_id}/withdraw" }
        end
      end
    end
  end
end
