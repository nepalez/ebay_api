class EbayAPI
  # Key for program types a seller can opt in
  class ProgramType < String
    extend Evil::Client::Dictionary["#{DICTIONARY_FILE}#program_type"]

    def self.call(value)
      super value.to_s.upcase
    end
  end
end
