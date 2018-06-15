class EbayAPI
  scope :sell do
    scope :account do
      scope :return_policies do
        operation :delete do
          path { return_policy_id }
          option :return_policy_id
          http_method :delete
          response(204) { true }
        end
      end
    end
  end
end
