class EbayAPI
  # @see https://developer.ebay.com/api-docs/sell/inventory/types/slr:PricingSummary
  class PricingSummary < Evil::Client::Model
    ref = "https://developer.ebay.com/api-docs/sell/inventory/types" \
          "/slr:PricingSummary"

    option :currency,
           type: Currency,
           desc: "Pricing currency",
           optional: true
    option :price,
           optional: true,
           desc: "listing price of the product"
    option :pricingVisibility,
           optional: true,
           type: PriceVisibility,
           as:   :visibility,
           desc: "Defines when map_price is shown (#{ref}#w4-w1-child-name-1)"
    option :minimumAdvertisedPrice,
           optional: true,
           as:    :min_price,
           desc: "Minimum Advertised Price"
    option :originallySoldForRetailPriceOn,
           optional: true,
           type: SoldType,
           as:   :sold_type,
           desc: "Defines when a product was sold (#{ref}#w4-w1-child-name-2)"
    option :originalRetailPrice,
           optional: true,
           as:   :retail_price,
           desc: "Original retail price"

    validate { errors.add :map_missed if visibility.nil? ^ min_price.nil? }
    validate { errors.add :stp_missed if sold_type.nil?  ^ retail_price.nil? }
    validate do
      prices   = [price, min_price, retail_price]
      required = prices.compact.any? { |item| !item.is_a? Hash }
      errors.add :currency_missed if required && !currency
    end

    def to_h
      {
        price:                          sum(price),
        pricingVisibility:              visibility,
        minimumAdvertisedPrice:         sum(min_price),
        originallySoldForRetailPriceOn: sold_type,
        originalRetailPrice:            sum(retail_price)
      }.reject { |_, value| value.nil? }
    end

    private

    def sum(value)
      case value
      when nil  then value
      when Hash then Amount[value].to_h
      else Amount[value: value, currency: currency].to_h
      end
    end
  end
end
