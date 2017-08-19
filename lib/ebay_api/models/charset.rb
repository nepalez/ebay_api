class EbayAPI
  class Charset < String
    class << self
      def call(value)
        charset = Encoding.find(value).to_s.downcase
        charset ? new(charset) : raise("Invalid charset #{value}")
      end
      alias [] call
    end
  end
end
