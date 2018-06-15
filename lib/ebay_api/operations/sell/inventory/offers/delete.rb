class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :delete do
          path { offer_id }
          option :offer_id
          http_method :delete
          response(204) { true }
        end
      end
    end
  end
end
