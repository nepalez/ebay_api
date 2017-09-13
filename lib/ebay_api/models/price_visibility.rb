class EbayAPI
  class PriceVisibility < String
    extend Evil::Client::Dictionary["config/dictionary.yml#price_visibility"]

    def self.call(value)
      super value.to_s.upcase
    end
  end
end
