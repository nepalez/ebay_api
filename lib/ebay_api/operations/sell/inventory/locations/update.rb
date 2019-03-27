class EbayAPI
  scope :sell do
    scope :inventory do
      scope :locations do
        operation :update do
          path { "#{merchant_location_key}/update_location_details" }
          option :merchant_location_key
          option :data
          http_method :post
          body do
            data
          end
          response(204) { true }
        end
      end
    end
  end
end
