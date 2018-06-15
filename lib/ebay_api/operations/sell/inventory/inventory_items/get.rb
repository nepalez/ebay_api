class EbayAPI
  scope :sell do
    scope :inventory do
      scope :inventory_items do
        operation :get do
          path { sku }
          option :sku
          http_method :get
          response(404) { nil }
        end
      end
    end
  end
end
