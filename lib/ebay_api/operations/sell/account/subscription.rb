require_relative "subscription/get"

class EbayAPI
  scope :sell do
    scope :account do
      scope :subscription do
        path { "subscription" }
      end
    end
  end
end
