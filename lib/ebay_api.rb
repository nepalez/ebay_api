require "evil/client"
require "yaml"

#
# Ruby client to Ebay RESTful JSON API
#
# @see http://developer.ebay.com/Devzone/rest/ebay-rest/content/ebay-rest-landing.html
#
# @example
#   client = EbayAPI.new token:       "foobar",
#                        version:     "1.1.0",
#                        language:    "en-US",
#                        site_id:     0,
#                        accept_gzip: true,
#                        sandbox:     true
#
#   client.inventory.
#
class EbayAPI < Evil::Client
  require_relative "ebay_api/collection"
  require_relative "ebay_api/version"
  require_relative "ebay_api/site"
  require_relative "ebay_api/currency"
  require_relative "ebay_api/language"
end
