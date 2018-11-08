class EbayAPI
  #
  # eBay Developer APIs
  #
  # @see https://developer.ebay.com/api-docs/developer/static/developer-landing.html
  #
  scope :developer do
    path "developer"

    require_relative "developer/analytics"
  end
end
