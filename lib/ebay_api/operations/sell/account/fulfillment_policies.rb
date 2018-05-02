require_relative "fulfillment_policies/create"
require_relative "fulfillment_policies/delete"
require_relative "fulfillment_policies/list"

class EbayAPI
  scope :sell do
    scope :account do
      scope :fulfillment_policies do
        path "fulfillment_policy"
      end
    end
  end
end
