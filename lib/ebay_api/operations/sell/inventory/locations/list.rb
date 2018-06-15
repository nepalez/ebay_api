class EbayAPI
  scope :sell do
    scope :inventory do
      scope :locations do
        operation :list do
          option :limit,  optional: true
          option :offset, optional: true
          http_method :get
          query do
            { limit: limit, offset: offset }.compact
          end
        end
      end
    end
  end
end
