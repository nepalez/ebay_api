# [WIP] EbayAPI

Ruby client to eBay RESTful JSON API

## Working with access tokens

eBay REST APIs (in contrast with XML APIs) are using short-lived (2 hours) OAuth access tokens, which can be renewed without end-user intervention.

See more at https://developer.ebay.com/api-docs/static/oauth-tokens.html

You may obtain OAuth tokens with, for example, [omniauth-ebay-oauth](https://github.com/evilmartians/omniauth-ebay-oauth) gem.

For access token renewal, a special [`EbayAPI::TokenManager`](lib/ebay_api/token_manager.rb) class is included into this gem.

 1. Instantiate it with access and refresh token information, that you have obtained on user sign in via OAuth (**not** Auth'n'Auth!) and your application's `appid` and `certid`.

    ```ruby

    require "ebay_api/token_manager"

    token_manager = EbayAPI::TokenManager.new(
      access_token:             account.access_token, # account is your user model instance
      access_token_expires_at:  account.access_token_expires_at,
      refresh_token:            account.refresh_token,
      refresh_token_expires_at: account.refresh_token_expires_at,
      appid:                    "Evil-Martians-PRD-deadbeef-12345f",
      certid:                   "PRD-d32dbe5f1337-1337-457b-3b3f-a379",
    )
    ```

 2. Provide its `access_token` method to the client (token manager will get a new token if needed).

    ```ruby
    client = EbayAPI.new(
      token: token_manager.method(:access_token),
      site: 0,
      language: 'en-US',
    )
    ```

If you're making a lot of consecutive call to APIs there is a high probability that access token will get expired between calls, and the token manager will ensure that you will always get a fresh token for every call with at least minute of remaining lifespan.

Also, you may wish to retry calls in case if `EbayAPI::InvalidAccessToken` error is raised: token might not be refreshed in time due to timing issues (clock drift, etc.)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

