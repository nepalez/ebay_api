class EbayAPI
  scope :sell do
    scope :account do
      scope :program do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/program/methods/optInToProgram
        operation :opt_in do
          option :program, ProgramType

          http_method :post
          path { "/opt_in" }
          body { { programType: program } }
        end
      end
    end
  end
end
