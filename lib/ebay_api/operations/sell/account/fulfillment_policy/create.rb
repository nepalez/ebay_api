class EbayAPI
  scope :sell do
    scope :account do
      scope :fulfillment_policy do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/fulfillment_policy/methods/createFulfillmentPolicy
        operation :create do
          option :policy, proc(&:to_h) # TODO: add model to validate input

          path { "/" }
          http_method :post
          body { policy }
        end
      end
    end
  end
end
