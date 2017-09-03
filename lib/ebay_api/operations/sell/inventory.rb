#
# Sell Inventory API
#
class EbayAPI
  scope :sell do
    scope :inventory do
      option :version, Version[:sell, :inventory], default: -> {}
      path   { "inventory/v#{version.primary}" }

      require_relative "inventory/offers"
    end
  end
end
