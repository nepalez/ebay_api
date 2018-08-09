class EbayAPI
  scope :sell do
    scope :account do
      scope :fulfillment_policy do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/fulfillment_policy/methods/getFulfillmentPolicy
        operation :get do
          option :id, proc(&:to_s)

          path { id }
          http_method :get
        end
      end
    end
  end
end
