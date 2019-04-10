#
# Sell Fulfillment API
#
require_relative "fulfillment/orders"

class EbayAPI
  scope :sell do
    scope :fulfillment do
      path { "fulfillment/v1" }
    end
  end
end
