class EbayAPI
  scope :sell do
    scope :account do
      scope :fulfillment_policy do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/fulfillment_policy/methods/deleteFulfillmentPolicy
        operation :delete do
          option :id, proc(&:to_s)

          path { id }
          http_method :delete
        end
      end
    end
  end
end
