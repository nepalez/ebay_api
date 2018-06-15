require_relative "inventory_item_groups/create_or_replace"
require_relative "inventory_item_groups/delete"
require_relative "inventory_item_groups/get"

class EbayAPI
  scope :sell do
    scope :inventory do
      scope :inventory_item_groups do
        path "inventory_item_group"
      end
    end
  end
end
