#
# Sell Inventory API
#

require_relative "inventory/offers"
require_relative "inventory/locations"

class EbayAPI
  scope :sell do
    scope :inventory do
      path { "inventory/v#{EbayAPI::SELL_INVENTORY_VERSION[/^\d+/]}" }
    end
  end
end
