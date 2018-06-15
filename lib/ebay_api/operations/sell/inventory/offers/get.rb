class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :get do
          option :offer_id
          http_method :get
          path { offer_id.to_s }
        end
      end
    end
  end
end
