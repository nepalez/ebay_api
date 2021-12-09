class EbayAPI
  scope :sell do
    scope :account do
      scope :payment_policy do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/payment_policy/methods/getPaymentPolicyByName
        operation :get_by_name do
          option :site, Site
          option :name, proc(&:to_s)

          path  { "/get_by_policy_name" }
          query { { marketplace_id: site.key, name: name } }
          http_method :get
        end
      end
    end
  end
end
