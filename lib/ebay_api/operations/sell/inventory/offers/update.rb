class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :update do
          path { offer_id }
          option :offer_id
          option :content_language
          option :data
          http_method :put
          headers { { "Content-Language" => content_language } }
          body do
            data
          end
          response(204) { true }
        end
      end
    end
  end
end
