class EbayAPI
  class ReplaceRequestHeaders
    def initialize(app)
      @app = app
    end

    def call(env)
      if env["REQUEST_METHOD"] == "POST" &&
          env["PATH_INFO"].match?('\A\/commerce\/media\/v1_beta\/video\/[a-z0-9]+\/upload$')
        env["HTTP_Variables"]["Content-Type"] = "application/octet-stream"
      end

      @app.call(env)
    end
  end
end
