class EbayAPI
  scope :sell do
    scope :account do
      scope :return_policies do
        operation :update do
          path { return_policy_id }
          option :return_policy_id
          option :data
          http_method :put
          body do
            data
          end
          response(201) { |_, _, (data, *)| data }
        end
      end
    end
  end
end
