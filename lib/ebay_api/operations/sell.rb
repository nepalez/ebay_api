#
# Sell API
#

require_relative "sell/account"
require_relative "sell/fulfillment"
require_relative "sell/inventory"
require_relative "sell/marketing"

class EbayAPI
  scope :sell do
    path "sell"
  end
end
