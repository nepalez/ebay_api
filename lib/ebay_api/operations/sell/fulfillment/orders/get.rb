class EbayAPI
  scope :sell do
    scope :fulfillment do
      scope :orders do
        operation :get do
          option :order_id
          http_method :get
          path { order_id.to_s }
        end
      end
    end
  end
end
