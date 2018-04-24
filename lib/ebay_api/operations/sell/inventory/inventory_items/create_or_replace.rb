class EbayAPI
  scope :sell do
    scope :inventory do
      scope :inventory_items do
        operation :create_or_replace do
          path { sku }
          option :sku
          option :content_language
          option :data
          http_method :put
          headers { { "Content-Language" => content_language } }
          body do
            data
          end
          response(204) { true }
        end
      end
    end
  end
end
