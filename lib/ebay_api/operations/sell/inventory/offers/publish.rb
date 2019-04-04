class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :publish do
          option :offer_id
          http_method :post
          path { "#{offer_id}/publish" }
        end
      end
    end
  end
end
