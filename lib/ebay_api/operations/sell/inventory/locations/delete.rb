class EbayAPI
  scope :sell do
    scope :inventory do
      scope :locations do
        operation :delete do
          path { merchant_location_key }
          option :merchant_location_key
          http_method :delete
          response(204) { true }
          response(404) { nil }
        end
      end
    end
  end
end
