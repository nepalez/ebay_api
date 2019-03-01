require_relative "rate_limit/get"

class EbayAPI
  scope :developer do
    scope :analytics do
      scope :rate_limit do
        path "rate_limit"
      end
    end
  end
end
