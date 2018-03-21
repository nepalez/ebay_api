class EbayAPI
  class Error < RuntimeError
    attr_reader :code

    def initialize(*args, code: nil, **)
      super(*args)
      @code = code
    end
  end

  class InvalidAccessToken < Error; end
  class AlreadyExists < Error; end

  # HTTP 500 from eBay. May be retried in most cases.
  class InternalServerError < Error; end

  class UserActionRequired < Error
    attr_reader :url

    def initialize(*, url: nil, **)
      super
      @url = url
    end
  end
end
