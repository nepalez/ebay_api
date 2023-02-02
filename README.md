# EbayAPI

> This gem is currently supported by the [ebaymag](https://ebaymag.com) team at [the corresponding fork](https://github.com/ebaymag/ebay_api). Please, send your issues and PR-s to that repository!

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


## Experimenting with API

For experimenting purposes, a `bin/console` script is provided.

You can work on behalf of different users by creating a YAML file with access and refresh tokens and your application credentials.

Example of file with user tokens: `seller-1.yml`

```yml
---
access_token: v^1.1#verylotofbase64datayeahthisisaccesstoken
access_token_expires_at: '2017-11-17T20:55:40+03:00'
refresh_token: v^1.1#notsolongtoken
refresh_token_expires_at: '2019-05-19T03:48:03Z'
appid: Evil-Martians-PRD-3000be115-88888888
certid: PRD-deadbeef69b0d-1337-4578-1379-3b3f
site: 0
language: en-US
```

Then you can launch a console with a path to a file:

```sh
bin/console seller-1.yml
```

In the console, `client` variable will contain API client configured with seller-1's credentials.

When the access token expires, it will be refreshed and written to file.


## Writing your own operations

See the [evil-client] gem docs.


### Paginated collections

For retrieving list of some entities eBay REST APIs provides endpoints with pagination. Page size is limited to 500 entities.

For allowing to retrieve more records `PaginatedCollection` middleware and result wrapper are provided.

 1. Wrap response from API to the `PaginatedCollection` instance to allow enumeration of records
 2. To rewrite `limit` parameter of outgoing requests, build and include special middleware in operation.

Example operation:

```ruby
scope :items do
  operation :list do
    http_method :get

    option :limit,  optional: true
    option :offset, optional: true

    query { { limit: limit, offset: offset }.compact }

    middleware { PaginatedCollection::MiddlewareBuilder.call }

    response(200) do |*response|
      PaginatedCollection.new(self, response, "items")
    end
  end
end
```

Usage:

```ruby
result = client.items.list

# Will issue requests to retrieve all records
result.each { |item| do_stuff }

# Will issue only requests needed to get required items
# (no additional requests if all of them are on the first page)
result.lazy.map { |item| item["itemId"] }.take(5).to_a

# Will get from 101st up to 1300th record with 3 requests (with limit `500`)
client.list(offset: 100, limit: 1200).to_a
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[evil-client]: https://github.com/evilmartians/evil-client "Human-friendly DSL for writing HTTP(S) clients to OpenAPI servers in Ruby"
