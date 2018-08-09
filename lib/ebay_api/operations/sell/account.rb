#
# Sell Inventory API
#
class EbayAPI
  scope :sell do
    scope :account do
      path { "account/v#{EbayAPI::SELL_ACCOUNT_VERSION[/^\d+/]}" }

      require_relative "account/privilege"
      require_relative "account/program"
      require_relative "account/fulfillment_policy"
    end
  end
end
