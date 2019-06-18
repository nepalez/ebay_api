require_relative "campaigns/create"
require_relative "campaigns/delete"
require_relative "campaigns/end"
require_relative "campaigns/find_by_ad_reference"
require_relative "campaigns/get"
require_relative "campaigns/get_by_name"
require_relative "campaigns/list"
require_relative "campaigns/pause"
require_relative "campaigns/resume"
require_relative "campaigns/update_identification"

#
# Promoted listing campaign management of the Marketing API
#
class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        path "ad_campaign"

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
