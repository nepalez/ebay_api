class EbayAPI
  class Charset < String
    extend Evil::Client::Dictionary

    def self.all
      @all ||= Encoding.name_list.map(&:downcase)
    end

    def self.call(value)
      value = value.to_s
      value = Encoding.find(value) || value
      value = value.to_s.downcase

      super value
    end
  end
end
