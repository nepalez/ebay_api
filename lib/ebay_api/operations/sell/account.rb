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
      require_relative "account/return_policy"
      require_relative "account/payment_policy"
      require_relative "account/payments_program"
      require_relative "account/subscription"
    end
  end
end
