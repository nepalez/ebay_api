class EbayAPI
  scope :sell do
    scope :account do
      scope :payment_policies do
        operation :list do
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
