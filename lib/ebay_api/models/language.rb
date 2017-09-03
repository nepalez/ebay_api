class EbayAPI
  # Key for a language
  class Language < String
    extend Collection
    extend Callable

    # @return [Array<EbayAPI::Language>] ordered list of supported languages
    def self.all
      @all ||= Site.languages
    end

    # Finds a language by its key
    # @param  [#to_s] key The key for a language
    # @return [String] if a language is supported
    # @raise  [StandardError] if a language isn't supported
    def self.call(key)
      find { |language| language == key.to_s.gsub("_", "-") } ||
        raise("Language '#{key}' not supported by eBay API")
    end
  end
end
