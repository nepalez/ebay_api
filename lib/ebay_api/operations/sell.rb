#
# Sell API
#
class EbayAPI
  scope :sell do
    path "sell"

    require_relative "sell/inventory"
  end
end
