class EbayAPI
  scope :sell do
    scope :account do
      scope :fulfillment_policy do
        path { "fulfillment_policy" }
      end
    end
  end
end

require_relative "fulfillment_policy/delete"
require_relative "fulfillment_policy/get"
require_relative "fulfillment_policy/get_by_name"
require_relative "fulfillment_policy/index"
require_relative "fulfillment_policy/create"
require_relative "fulfillment_policy/update"
