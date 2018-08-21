class EbayAPI
  class LogRequest
    def initialize(app)
      @app = app
    end

    def call(env)
      log_request(env)
      @app.call(env).tap { |output| log_response(output) }
    end

    private

    def logger
      @logger ||= EbayAPI.logger
    end

    def log_info(key, data = nil)
      logger.info "[EbayAPI] | #{format('%9s', key)} | #{data}"
    end

    def log_request(env)
      return unless logger
      log_info "REQUEST:"
      log_info "Url",     env["PATH_INFO"]
      log_info "Method",  env["REQUEST_METHOD"]
      log_info "Headers", env["HTTP_Variables"]
      log_info "Body",    env["rack.input"]
    end

    def log_response(output)
      return unless logger
      status, headers, body = output
      log_info "RESPONSE:"
      log_info "Status",  status
      log_info "Headers", headers
      log_info "Body",    body
    end
  end
end
