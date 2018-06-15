require_relative "return_policies/create"
require_relative "return_policies/delete"
require_relative "return_policies/update"
require_relative "return_policies/list"

class EbayAPI
  scope :sell do
    scope :account do
      scope :return_policies do
        path "return_policy"
      end
    end
  end
end
