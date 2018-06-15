class EbayAPI
  scope :sell do
    scope :inventory do
      scope :inventory_item_groups do
        operation :delete do
          path { inventory_item_group_key }
          option :inventory_item_group_key
          http_method :delete
          response(204) { true }
          response(404) { nil }
        end
      end
    end
  end
end
