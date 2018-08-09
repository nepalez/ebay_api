class EbayAPI
  scope :sell do
    scope :account do
      scope :return_policy do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/return_policy/methods/deleteReturnPolicy
        operation :delete do
          option :id, proc(&:to_s)

          path { id }
          http_method :delete
        end
      end
    end
  end
end
