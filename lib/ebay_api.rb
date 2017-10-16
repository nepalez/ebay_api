require "dry-equalizer"
require "evil/client"
require "yaml"

#
# Ruby client to Ebay RESTful JSON API
#
# @see http://developer.ebay.com/Devzone/rest/ebay-rest/content/ebay-rest-landing.html
#
# @example
#   client = EbayAPI.new token:    "foobar",
#                        version:  "1.1.0",
#                        language: "en-US",
#                        site_id:  0,
#                        gzip:     true,
#                        sandbox:  true
#
#   client.inventory.
#
class EbayAPI < Evil::Client
  require_relative "ebay_api/versions"
  require_relative "ebay_api/models"
  require_relative "ebay_api/operations"

  option :token,    proc(&:to_s)
  option :site,     Site,            optional: true
  option :language, Language,        optional: true
  option :charset,  Charset,         default:  proc { "utf-8" }
  option :sandbox,  true.method(:&), default:  proc { false }
  option :gzip,     true.method(:&), default:  proc { false }

  validate do
    return unless language && site
    return if site.languages.include?(language)
    errors.add :wrong_language, language: language, site: site
  end

  format   "json"
  path     { "https://api#{".sandbox" if sandbox}.ebay.com/" }
  security { token_auth token, prefix: "Bearer" }
  headers do
    {
      "Accept-Language":  language,
      "Accept-Charset":   charset,
      "X-Ruby-Client":    "https://github.com/nepalez/ebay_api",
      "X-Ruby-Framework": "https://github.com/evilmartians/evil-client"
    }
  end
  response(200) { |_, _, body| JSON.parse(body.first) }
end
