class EbayAPI
  # Key for a language
  class Language < String
    extend Evil::Client::Dictionary

    # @return [Array<EbayAPI::Language>] ordered list of supported languages
    def self.all
      @all ||= Site.languages
    end

    # Finds a language by its key
    # @param  [#to_s] key The key for a language
    # @return [String] if a language is supported
    # @raise  [StandardError] if a language isn't supported
    def self.call(key)
      super key.to_s.gsub("_", "-")
    end
  end
end
