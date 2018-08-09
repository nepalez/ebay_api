class EbayAPI
  scope :sell do
    scope :account do
      scope :fulfillment_policy do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/fulfillment_policy/methods/getFulfillmentPolicies
        operation :index do
          option :site, Site

          path  { "/" }
          query { { marketplace_id: site.key } }
          http_method :get
        end
      end
    end
  end
end
