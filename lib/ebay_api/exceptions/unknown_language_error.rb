require_relative "../models/language"

class EbayApi::UnknownLanguageError < ArgumentError
  private

  def initialize(key)
    list = EbayApi::Language::SUPPORTED.join(", ")
    super "Language '#{key}' is not supported by eBay RESTful API." \
          " Use one of the following languages: #{list}."
  end
end
