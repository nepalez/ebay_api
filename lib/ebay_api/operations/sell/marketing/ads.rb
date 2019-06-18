require_relative "ads/bulk_create_by_listing_id"
require_relative "ads/bulk_delete_by_listing_id"
require_relative "ads/bulk_update_bid_by_listing_id"
require_relative "ads/create_by_listing_id"
require_relative "ads/delete"
require_relative "ads/get"
require_relative "ads/list"
require_relative "ads/update_bid"

#
# Promoted listing management of the Marketing API
#
class EbayAPI
  scope :sell do
    scope :marketing do
      scope :ads do
        path { "ad_campaign/#{campaign_id}" }
        option :campaign_id

        response(400, 409) do |_, _, (data, *)|
          code = data.dig("errors", 0, "errorId")
          message = data.dig("errors", 0, "message")
          case code
          when 35_060, 35_067, 35_077
            raise EbayAPI::UserActionRequired.new(code: code), message
          else
            super!
          end
        end
      end
    end
  end
end
