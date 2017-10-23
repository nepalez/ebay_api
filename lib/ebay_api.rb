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

  class Error < RuntimeError; end
  class InvalidAccessToken < RuntimeError; end

  option :token
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

  security do
    token_value = token.respond_to?(:call) ? token.call : token
    token_auth token_value, prefix: "Bearer"
  end

  headers do
    {
      "Accept-Language":  language,
      "Accept-Charset":   charset,
      "X-Ruby-Client":    "https://github.com/nepalez/ebay_api",
      "X-Ruby-Framework": "https://github.com/evilmartians/evil-client"
    }
  end

  response(200) { |_, _, body| JSON.parse(body.first) }

  response(401) do |_, _, body|
    data = JSON.parse(body.first)
    case data.dig("errors", 0, "errorId")
    when 1001
      raise InvalidAccessToken, data.dig("errors", 0, "longMessage")
    else
      raise Error, data.dig("errors", 0, "longMessage")
    end
  end
end
