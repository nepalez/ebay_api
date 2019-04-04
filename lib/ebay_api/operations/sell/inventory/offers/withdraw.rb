class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :withdraw do
          option :offer_id

          http_method :post
          path { "#{offer_id}/withdraw" }
        end
      end
    end
  end
end
