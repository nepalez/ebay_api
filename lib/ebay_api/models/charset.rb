class EbayAPI
  class Charset < String
    extend Callable

    private

    def initialize(value)
      charset = Encoding.find(value).to_s.downcase
      charset ? super(charset) : raise("Invalid charset #{value}")
    end
  end
end
