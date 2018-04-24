class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :list do
          option :sku
          option :limit, optional: true
          option :offset, optional: true

          http_method :get
          query do
            { sku: sku, limit: limit, offset: offset }.select { |_, v| v }
          end
          response(404) { nil }
        end
      end
    end
  end
end
