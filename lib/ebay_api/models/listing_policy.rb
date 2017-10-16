class EbayAPI
  class ListingPolicy < Evil::Client::Model
    option :payment_policy_id
    option :return_policy_id
    option :shipping_cost_overrides
    option :fulfillment_policy_id

    def to_h
      {
        paymentPolicyId:       payment_policy_id,
        returnPolicyId:        return_policy_id,
        shippingCostOverrides: shipping_cost_overrides,
        fulfillmentPolicyId:   fulfillment_policy_id
      }
    end
  end
end
