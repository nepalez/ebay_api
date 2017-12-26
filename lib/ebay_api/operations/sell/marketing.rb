#
# Sell Inventory API
#
class EbayAPI
  scope :sell do
    scope :marketing do
      path { "marketing/v#{EbayAPI::SELL_MARKETING_VERSION[/^\d+/]}" }

      require_relative "marketing/campaigns"
      require_relative "marketing/ads"
    end
  end
end
