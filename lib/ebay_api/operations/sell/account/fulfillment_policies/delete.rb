class EbayAPI
  scope :sell do
    scope :account do
      scope :fulfillment_policies do
        operation :delete do
          http_method :delete
          path { fulfillment_policy_id }
          option :fulfillment_policy_id
          response(204) { true }
        end
      end
    end
  end
end
