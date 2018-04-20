class EbayAPI
  scope :sell do
    scope :account do
      scope :privilege do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/privilege/methods/getPrivileges
        operation :get do
          http_method :get
          path { "/" }
        end
      end
    end
  end
end
