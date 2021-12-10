require "securerandom"

# Parses gzipped response
class EbayAPI
  class SaveToFileResponse
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      [status, headers, body.map { |b| save(b) }]
    end

    private

    def save(body)
      return unless body
      return if body.empty?

      file = File.new("/tmp/ebay-api-response-#{SecureRandom.hex}", "w+b")
      file.write(body)
      file.flush
      file.close
      { "filename" => file.path }.to_json
    end
  end
end
