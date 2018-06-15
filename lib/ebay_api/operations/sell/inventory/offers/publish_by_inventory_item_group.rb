class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :publish_by_inventory_item_group do
          path "publish_by_inventory_item_group"
          http_method :post
          option :inventory_item_group_key
          option :marketplace_id
          body do
            {
              'inventoryItemGroupKey': inventory_item_group_key,
              'marketplaceId': marketplace_id
            }
          end
        end
      end
    end
  end
end
