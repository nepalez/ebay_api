class EbayAPI
  # Key for a currency
  class Currency < String
    # Enumerable collection of the currencies supported by eBay
    class << self
      include Collection

      # @return [Array<EbayAPI::Language>] ordered list of supported currencies
      def all
        @all ||= Site.currencies
      end

      # Finds a currency by its key
      # @param  [#to_s] key The key for a currency
      # @return [String] if a currency is supported
      # @raise  [StandardError] if a currency isn't supported
      def call(key)
        find { |currency| currency == key.to_s } ||
          raise("Currency '#{key}' not supported by eBay API")
      end
    end
  end
end
