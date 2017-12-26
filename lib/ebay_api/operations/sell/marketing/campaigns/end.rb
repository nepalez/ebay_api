class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        # @see https://developer.ebay.com/api-docs/sell/marketing/resources/campaign/methods/endCampaign
        operation :end do
          http_method :post
          path { "#{campaign_id}/end" }

          option :campaign_id

          response(204) { true }
          response(400, 409) do |_, _, (data, *)|
            case data.dig("errors", 0, "errorId")
            when 35035 then next true # Already ended, nothing to do here
            else super!
            end
          end
        end
      end
    end
  end
end
