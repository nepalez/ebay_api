class EbayAPI
  scope :sell do
    scope :account do
      scope :payment_policies do
        operation :create do
          option :data
          http_method :post
          body do
            data
          end
          response(201) { |_, _, (data, *)| data }
        end
      end
    end
  end
end
