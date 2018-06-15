require_relative "inventory_items/create_or_replace"
require_relative "inventory_items/delete"
require_relative "inventory_items/get"
require_relative "inventory_items/list"

class EbayAPI
  scope :sell do
    scope :inventory do
      scope :inventory_items do
        path "inventory_item"
      end
    end
  end
end
