# Parses API response as JSON
class EbayAPI
  class JSONResponse
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      [status, headers, body.map { |b| parse(b) }]
    end

    private

    def parse(body)
      return unless body
      return if body.empty?

      JSON.parse(body)
    end
  end
end
