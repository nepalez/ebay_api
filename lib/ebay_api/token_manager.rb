# frozen_string_literal: true

require_relative "../ebay_api"

# Holds access token from OAuth method for using with all eBay APIs
# Retrieves new access token every time when current become outdated.
# @see https://developer.ebay.com/api-docs/static/oauth-qref-auth-code-grant.html
class EbayAPI::TokenManager
  extend Dry::Initializer

  class RefreshTokenExpired < EbayAPI::Error; end
  class RefreshTokenInvalid < EbayAPI::Error; end

  option :access_token
  option :access_token_expires_at
  option :refresh_token
  option :refresh_token_expires_at
  option :appid
  option :certid
  option :on_refresh,               optional: true
  option :sandbox,                  optional: true, default: proc { false }

  # @!method initialize(options)
  #   @option options [String] access_token
  #     Short-living access token
  #   @option options [Time]   access_token_expires_at
  #     Timestamp of the +access_token+ expiry time.
  #   @option options [String] refresh_token
  #     Long-living token to get new access tokens
  #   @option options [Time]   refresh_token_expires_at
  #     Timestamp of the +refresh_token+ expiry time.
  #   @option options [String] appid
  #     Your application's OAuth credentials identifier
  #   @option options [String] certid
  #     Your application's OAuth credentials secret
  #   @option options [#call]  on_refresh
  #     Callback. Will be called after successful renewal with two arguments:
  #     new access token and its expiration time

  # Returns access token (retrieves and returns new one if it has expired)
  def access_token
    refresh! if access_token_expires_at&.<= Time.now + 60 # time drift margin
    @access_token
  end

  # Requests new access token, use +access_token+ to get its contents.
  def refresh!
    now = Time.now
    raise RefreshTokenExpired if refresh_token_expires_at&.<= now

    data = refresh_token_request!

    @access_token = data["access_token"]
    @access_token_expires_at = (now + data["expires_in"])

    on_refresh&.call(@access_token, @access_token_expires_at)
  end

  private

  def refresh_token_request!
    response =
      request! token_endpoint,
               grant_type: "refresh_token", refresh_token: refresh_token
    body = JSON.parse(response.body)
    return body if response.is_a? Net::HTTPSuccess
    handle_errors!(body)
  rescue JSON::ParserError
    message = "Response isn't JSON: #{response.code} - #{response.body}"
    raise EbayAPI::Error, "Can't refresh access token: #{message}"
  end

  def handle_errors!(response)
    cause = response.values_at("error", "error_description").compact.join(" - ")
    cause = response if cause.length.zero?
    case response["error"]
    when "server_error"
      raise EbayAPI::InternalServerError, cause
    when "invalid_grant", "unauthorized_client"
      raise RefreshTokenInvalid, cause
    else
      raise EbayAPI::Error, "Can't refresh access token: #{cause}"
    end
  end

  def token_endpoint
    environment = sandbox ? ".sandbox" : ""
    "https://api#{environment}.ebay.com/identity/v1/oauth2/token"
  end

  def request!(url, data)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port).tap do |http|
      http.use_ssl = uri.scheme == "https"
    end
    post = Net::HTTP::Post.new(uri.path)
    post.body = URI.encode_www_form(data)
    post.basic_auth appid, certid
    http.start { |r| r.request(post) }
  end
end
