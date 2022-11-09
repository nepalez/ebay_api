class EbayAPI
  scope :sell do
    scope :account do
      scope :subscription do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/subscription/methods/getSubscription
        operation :get do
          option :limit, proc(&:to_s), optional: true
          option :continuation_token, proc(&:to_s), optional: true

          path  { "/" }
          query { { limit: limit, continuation_token: continuation_token }.compact }
          http_method :get
        end
      end
    end
  end
end
