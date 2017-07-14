require "evil/client"
require "yaml"

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
  require_relative "ebay_api/models/charset"
  require_relative "ebay_api/models/site"
  require_relative "ebay_api/models/language"

  require_relative "ebay_api/exceptions/unknown_api_error"
  require_relative "ebay_api/exceptions/version_number_error"
  require_relative "ebay_api/exceptions/unknown_site_error"
  require_relative "ebay_api/exceptions/unknown_language_error"

  BOOLEAN = proc { |v| !!v }
  settings do
    option :token,       proc(&:to_s)
    option :site_id,     Site,     optional: true, as: :site
    option :language,    Language, optional: true
    option :charset,     Charset,  default: proc { Charset["utf-8"] }
    option :sandbox,     BOOLEAN,  default: proc { false }
    option :accept_gzip, BOOLEAN,  default: proc { false }
  end

  base_url do |settings|
    "https://api#{".sandbox" if settings.sandbox}.ebay.com/"
  end
end
