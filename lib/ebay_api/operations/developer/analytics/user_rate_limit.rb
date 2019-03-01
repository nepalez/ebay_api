require_relative "user_rate_limit/get"

class EbayAPI
  scope :developer do
    scope :analytics do
      scope :user_rate_limit do
        path "user_rate_limit"
      end
    end
  end
end
