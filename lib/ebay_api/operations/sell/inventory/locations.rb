require_relative "locations/create"
require_relative "locations/delete"
require_relative "locations/get"

class EbayAPI
  scope :sell do
    scope :inventory do
      scope :locations do
        path "location"
      end
    end
  end
end
