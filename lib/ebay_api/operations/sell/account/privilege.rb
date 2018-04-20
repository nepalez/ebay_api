require_relative "privilege/get"

class EbayAPI
  scope :sell do
    scope :account do
      scope :privilege do
        path { "privilege" }
      end
    end
  end
end
