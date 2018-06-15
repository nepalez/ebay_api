require_relative "offers/create"
require_relative "offers/delete"
require_relative "offers/get"
require_relative "offers/get_listing_fees"
require_relative "offers/list"
require_relative "offers/publish"
require_relative "offers/publish_by_inventory_item_group"
require_relative "offers/update"
require_relative "offers/withdraw"
#
# Offers-related operations of the inventory API
#
class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        path "offer"
      end
    end
  end
end
