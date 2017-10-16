class EbayAPI
  # @see
  #   https://developer.ebay.com/api-docs/sell/inventory/types/slr:ShippingCostOverride
  class ShippingCost < Evil::Client::Model
    option :priority,        proc(&:to_i)
    option :service_type,    ServiceType
    option :additional_cost, Amount, optional: true
    option :cost,            Amount, optional: true
    option :surcharge,       Amount, optional: true

    def to_h
      {
        priority:            priority,
        shippingServiceType: service_type,
        additionalCost:      additional_cost.to_h,
        cost:                cost.to_h,
        surcharge:           surcharge.to_h
      }
    end
  end
end
