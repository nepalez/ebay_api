class EbayAPI
  # Service type
  class SoldType < String
    extend Evil::Client::Dictionary["config/dictionary.yml#sold_type"]

    def self.call(value)
      super value.to_s.upcase
    end
  end
end
