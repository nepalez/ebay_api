class EbayAPI
  class AddVideoIdToBody
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      body = if status == 201 &&
                headers.keys.include?("location") &&
                env["REQUEST_METHOD"] == "POST" &&
                env["PATH_INFO"] == "/commerce/media/v1_beta/video/"
               [{ "id" => headers["location"][0].split("/").last }]
             else
               body
             end

      [status, headers, body]
    end
  end
end
