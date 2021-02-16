class EbayAPI
  scope :sell do
    scope :account do
      scope :payments_program do
        # @see https://developer.ebay.com/api-docs/sell/account/resources/payments_program/methods/getPaymentsProgram
        operation :get do
          option :site, Site
          option :type, proc(&:to_s), default: -> { "EBAY_PAYMENTS" }

          http_method :get
          path { "/#{site.key}/#{type}" }
        end
      end
    end
  end
end
