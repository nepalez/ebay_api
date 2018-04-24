require_relative "return_policies/create"
require_relative "return_policies/delete"
require_relative "return_policies/get"

class EbayAPI
  scope :sell do
    scope :account do
      scope :return_policies do
        path "return_policy"
      end
    end
  end
end
