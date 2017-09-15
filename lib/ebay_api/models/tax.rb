class EbayAPI
  class Tax < Evil::Client::Model
    option :vatPercentage,
           type: ->(v) { v.to_f.round(3) },
           as: :vat,
           desc: "VAT percentage (0-100%)"
    option :applyTax,
           type: ->(v) { v.to_s == "true" },
           as: :apply_tax,
           default: -> { true },
           desc: "(true) Whether a tax should be applied"

    validate { errors.add :negative_vat, vat: vat if vat.negative? }
    validate { errors.add :robbery_vat,  vat: vat if vat > 100 }

    def to_h
      { applyTax: apply_tax, vatPercentage: vat }
    end
  end
end
