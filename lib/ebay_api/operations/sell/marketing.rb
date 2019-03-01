#
# Sell Inventory API
#

require_relative "marketing/campaigns"
require_relative "marketing/ads"

class EbayAPI
  scope :sell do
    scope :marketing do
      path { "marketing/v#{EbayAPI::SELL_MARKETING_VERSION[/^\d+/]}" }
    end
  end
end
