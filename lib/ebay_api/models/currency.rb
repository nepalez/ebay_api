class EbayAPI
  # Key for a currency
  class Currency < String
    extend Collection
    extend Callable

    # @return [Array<EbayAPI::Language>] ordered list of supported currencies
    def self.all
      @all ||= Site.currencies
    end

    # Finds a currency by its key
    # @param  [#to_s] key The key for a currency
    # @return [String] if a currency is supported
    # @raise  [StandardError] if a currency isn't supported
    def self.call(key)
      find { |currency| currency == key.to_s } ||
        raise("Currency '#{key}' not supported by eBay API")
    end
  end
end
