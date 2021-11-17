require "zlib"
require "stringio"

# Parses gzipped response
class EbayAPI
  class GzippedResponse
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, gz_body = @app.call(env)

      [status, headers, gz_body.map { |b| unzip(b) }]
    end

    private

    def unzip(body)
      return unless body
      return if body.empty?

      Zlib::GzipReader.new(StringIO.new(body.to_s)).read
    end
  end
end
