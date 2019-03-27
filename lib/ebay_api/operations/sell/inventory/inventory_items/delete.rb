class EbayAPI
  scope :sell do
    scope :inventory do
      scope :inventory_items do
        operation :delete do
          path { sku }
          option :sku
          http_method :delete
          response(204) { true }
          response(404) { false }
        end
      end
    end
  end
end
