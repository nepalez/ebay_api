class EbayAPI
  scope :sell do
    scope :account do
      scope :program do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/program/methods/getOptedInPrograms
        operation :get do
          http_method :get
          path { "get_opted_in_programs" }
        end
      end
    end
  end
end
