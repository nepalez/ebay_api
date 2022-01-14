class EbayAPI
  scope :sell do
    scope :account do
      scope :payment_policy do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/payment_policy/methods/getPaymentPolicy
        operation :get do
          option :id, proc(&:to_s)

          path { id }
          http_method :get
        end
      end
    end
  end
end
