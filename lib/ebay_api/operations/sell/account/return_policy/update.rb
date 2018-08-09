class EbayAPI
  scope :sell do
    scope :account do
      scope :return_policy do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/return_policy/methods/updateReturnPolicy
        operation :update do
          option :id,     proc(&:to_s)
          option :policy, proc(&:to_h) # TODO: add model to validate input

          path { id }
          http_method :post
          body { policy }
        end
      end
    end
  end
end
