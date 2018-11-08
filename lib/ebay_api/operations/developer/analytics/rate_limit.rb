class EbayAPI
  scope :developer do
    scope :analytics do
      scope :rate_limit do
        path "rate_limit"

        require_relative "rate_limit/get"
      end
    end
  end
end
