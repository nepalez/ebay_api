#
# Sell API
#
class EbayAPI
  scope :sell do
    path "sell"

    require_relative "sell/inventory"
    require_relative "sell/marketing"
  end
end
