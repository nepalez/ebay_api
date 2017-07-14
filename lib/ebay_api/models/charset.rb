require_relative "callable"

class EbayApi::Charset < String
  extend EbayApi::Callable

  private

  def initialize(value)
    super Encoding.find(value).to_s.downcase
  end
end
