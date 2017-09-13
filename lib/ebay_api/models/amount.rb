class EbayAPI
  # @see
  #   https://developer.ebay.com/api-docs/sell/inventory/types/slr:Amount
  class Amount < Evil::Client::Model
    include Dry::Equalizer(:currency, :value)
    option :value,    ->(v) { v.to_f.round(2) }
    option :currency, Currency

    validate { errors.add :negative_value, to_h if value.negative? }

    def to_h
      { value: value.to_s, currency: currency.code }
    end
  end
end
