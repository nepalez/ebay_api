class EbayAPI
  class Error < RuntimeError
    attr_reader :code, :data

    def initialize(*args, code: nil, data: nil, **)
      super(*args)
      @code = code
      @data = data
    end
  end

  class InvalidAccessToken < Error; end
  class AlreadyExists < Error; end

  # HTTP 500 from eBay. May be retried in most cases.
  class InternalServerError < Error; end

  # HTTP 429 from eBay. Indicates that daily API call limit has been reached.
  #
  # Call limits are individual for every API,
  # see https://go.developer.ebay.com/api-call-limits
  class RequestLimitExceeded < Error; end

  class UserActionRequired < Error
    attr_reader :url

    def initialize(*, url: nil, **)
      super
      @url = url
    end
  end
end
