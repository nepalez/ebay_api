class EbayAPI
  scope :sell do
    scope :account do
      scope :payment_policies do
        operation :delete do
          http_method :delete
          path { payment_policy_id }
          option :payment_policy_id
          response(204) { true }
        end
      end
    end
  end
end
