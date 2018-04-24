class EbayAPI
  scope :sell do
    scope :inventory do
      scope :inventory_item_groups do
        operation :get do
          path { inventory_item_group_key }
          option :inventory_item_group_key

          http_method :get
          query do
            { inventoryItemGroupKey: inventory_item_group_key }
              .select { |_, v| v }
          end
          response(404) { nil }
        end
      end
    end
  end
end
