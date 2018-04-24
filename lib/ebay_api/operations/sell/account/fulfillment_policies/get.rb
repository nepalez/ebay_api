class EbayAPI
  scope :sell do
    scope :account do
      scope :fulfillment_policies do
        operation :get do
          option :marketplace_id
          http_method :get
          query do
            { marketplace_id: marketplace_id }
          end
        end
      end
    end
  end
end
