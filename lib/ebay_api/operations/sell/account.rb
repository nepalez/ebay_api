#
# Sell Inventory API
#
class EbayAPI
  scope :sell do
    scope :account do
      path { "account/v#{EbayAPI::SELL_ACCOUNT_VERSION[/^\d+/]}" }

      require_relative "account/privilege"
      require_relative "account/program"
    end
  end
end
