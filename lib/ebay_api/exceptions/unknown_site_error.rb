require_relative "../models/site"

class EbayApi::UnknownSiteError < ArgumentError
  private

  def initialize(id)
    list = EbayApi::Site::SUPPORTED.map do |item|
      "#{item["id"]}: #{item["code"]} (#{item["languages"].join(", ")})"
    end.join(", ")

    super "The eBay marketplace (site) with id:#{id} is unknown." \
          " Use one of the following sites: #{list}."
  end
end
