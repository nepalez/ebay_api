class EbayAPI
  scope :sell do
    scope :account do
      scope :payment_policy do
        path { "payment_policy" }
      end
    end
  end
end

require_relative "payment_policy/delete"
require_relative "payment_policy/get"
require_relative "payment_policy/get_by_name"
require_relative "payment_policy/index"
require_relative "payment_policy/create"
require_relative "payment_policy/update"
