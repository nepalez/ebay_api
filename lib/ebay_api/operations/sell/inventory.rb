#
# Sell Inventory API
#
class EbayAPI
  scope :sell do
    scope :inventory do
      path { "inventory/v#{EbayAPI::SELL_INVENTORY_VERSION[/^\d+/]}" }

      require_relative "inventory/inventory_item_groups"
      require_relative "inventory/inventory_items"
      require_relative "inventory/locations"
      require_relative "inventory/offers"
    end
  end
end
