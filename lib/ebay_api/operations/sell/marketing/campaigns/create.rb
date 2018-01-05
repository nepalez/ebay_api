class EbayAPI
  scope :sell do
    scope :marketing do
      scope :campaigns do
        operation :create do
          option :campaign, type: CreateCampaignRequest

          http_method :post

          body { campaign.to_h }

          response(201) do |_, headers, _|
            headers["location"].first
          end

          response(400, 409) do |_, _, (data, *)|
            msg = data.dig("errors", 0, "message")
            case (code = data.dig("errors", 0, "errorId"))
            when 35_021
              raise EbayAPI::AlreadyExists.new(code: code), msg
            when 35_067
              url = data.dig("errors", 0, "parameters").find do |e|
                e["name"] == "userAgreementLink"
              end&.dig("value")
              raise EbayAPI::UserActionRequired.new(code: code, url: url), msg
            else
              super!
            end
          end
        end
      end
    end
  end
end
