require "evil/client"

#
# Ruby client to Ebay RESTful JSON API
#
# @see http://developer.ebay.com/Devzone/rest/ebay-rest/content/ebay-rest-landing.html
#
# @example
#   client = EbayApi.new token:    "foobar",
#                        version:  "1.1.0",
#                        language: "en-US",
#                        site_id:  0,
#                        gzip:     true,
#                        sandbox:  true
#
#   client.inventory.
#
class EbayApi
  extend Evil::Client::DSL

  require_relative "ebay_api/models/version"

  require_relative "ebay_api/exceptions/unknown_api_error"
  require_relative "ebay_api/exceptions/version_number_error"
end
