require_relative 'orders/get'

class EbayAPI
  scope :sell do
    scope :fulfillment do
      scope :orders do
        path "order"
      end
    end
  end
end
