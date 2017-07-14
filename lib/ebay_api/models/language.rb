require_relative "site"

class EbayApi::Language < String
  extend EbayApi::Callable

  def self.new(key)
    name = key.to_s
    return super(name) if SUPPORTED.include?(name)
    raise EbayApi::UnknownLanguageError.new(key)
  end

  SUPPORTED = EbayApi::Site::SUPPORTED.flat_map { |item| item["languages"] }
                                      .uniq
                                      .sort
                                      .freeze
end
