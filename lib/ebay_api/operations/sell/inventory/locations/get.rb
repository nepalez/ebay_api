class EbayAPI
  scope :sell do
    scope :inventory do
      scope :locations do
        operation :get do
          option :limit,  optional: true
          option :offset, optional: true
          http_method :get
          query do
            { limit: limit, offset: offset }.select { |_, v| v }
          end
        end
      end
    end
  end
end
