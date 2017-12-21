# Parses API response as JSON
class EbayAPI
  class JSONResponse
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      [status, headers, body.map { |b| JSON.parse(b) unless b&.empty? }]
    end
  end
end
