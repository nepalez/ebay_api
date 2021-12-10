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
  GEM_ROOT = File.dirname(__dir__)
  DICTIONARY_FILE = File.join(GEM_ROOT, *%w[config dictionary.yml])

  require_relative "ebay_api/versions"
  require_relative "ebay_api/models"
  require_relative "ebay_api/operations"
  require_relative "ebay_api/middlewares"
  require_relative "ebay_api/exceptions"

  class << self
    attr_accessor :logger
  end

  option :token
  option :site,       Site,            optional: true
  option :language,   Language,        optional: true
  option :charset,    Charset,         default:  proc { "utf-8" }
  option :sandbox,    true.method(:&), default:  proc { false }
  option :gzip,       true.method(:&), default:  proc { false }
  option :user_agent, method(:String), optional: true

  validate do
    next unless language && site
    next if site.languages.include?(language)
    errors.add :wrong_language, language: language, site: site
  end

  format "json"
  path   { "https://api#{".sandbox" if sandbox}.ebay.com/" }

  middleware { [LogRequest, JSONResponse] }

  security do
    token_value = token.respond_to?(:call) ? token.call : token
    token_auth token_value, prefix: "Bearer"
  end

  headers do
    {
      "Accept-Language":  language,
      "Accept-Charset":   charset,
      "User-Agent":       user_agent,
      "X-Ruby-Client":    "https://github.com/nepalez/ebay_api",
      "X-Ruby-Framework": "https://github.com/evilmartians/evil-client"
    }.compact
  end

  response(200, 201) { |_, _, (data, *)| data }

  response(204) { true }

  # https://developer.ebay.com/api-docs/static/handling-error-messages.html
  response(400, 401, 409) do |_, _, (data, *)|
    data = data.to_h
    error = data.dig("errors", 0) || {}
    code = error["errorId"]
    message = error["longMessage"] || error["message"]

    case code
    when 1001
      raise InvalidAccessToken.new(code: code), message
    else
      raise Error.new(code: code, data: data), message
    end
  end

  # https://go.developer.ebay.com/api-call-limits
  response(429) do |_, _, (data, *)|
    data = data.to_h
    error = data.dig("errors", 0) || {}
    code = error["errorId"]
    message = error["longMessage"] || error["message"]
    raise RequestLimitExceeded.new(code: code), message
  end

  response(500) do |_, _, (data, *)|
    data = data.to_h
    code = data.dig("errors", 0, "errorId")
    message =
        data.dig("errors", 0, "longMessage") || data.dig("errors", 0, "message")
    raise InternalServerError.new(code: code), message
  end
end
