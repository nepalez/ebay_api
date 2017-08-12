class EbayAPI
  # Key for a language
  class Language < String
    # Enumerable collection of the languages supported by eBay
    class << self
      include Collection

      # @return [Array<EbayAPI::Language>] ordered list of supported languages
      def all
        @all ||= Site.languages
      end

      # Finds a language by its key
      # @param  [#to_s] key The key for a language
      # @return [String] if a language is supported
      # @raise  [StandardError] if a language isn't supported
      def call(key)
        find { |language| language == key.to_s } ||
          raise("Language '#{key}' not supported by eBay API")
      end
    end
  end
end
