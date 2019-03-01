#
# Sell Inventory API
#

require_relative "account/privilege"
require_relative "account/program"
require_relative "account/fulfillment_policy"
require_relative "account/return_policy"

class EbayAPI
  scope :sell do
    scope :account do
      path { "account/v#{EbayAPI::SELL_ACCOUNT_VERSION[/^\d+/]}" }
    end
  end
end
