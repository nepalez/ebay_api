class EbayAPI
  scope :commerce do
    scope :notifications do
      # @see https://developer.ebay.com/api-docs/commerce/notification/resources/public_key/methods/getPublicKey
      scope :public_key do
        operation :get do
          option :key_id, proc(&:to_s)

          path { key_id }
          http_method :get
        end
      end
    end
  end
end
