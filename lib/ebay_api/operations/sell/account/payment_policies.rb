require_relative "payment_policies/create"
require_relative "payment_policies/delete"
require_relative "payment_policies/list"

class EbayAPI
  scope :sell do
    scope :account do
      scope :payment_policies do
        path "payment_policy"
      end
    end
  end
end
