class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :create do
          option :content_language
          http_method :post
          option :data
          headers { { "Content-Language" => content_language } }
          body do
            data
          end
          response(201) { |_, _, (data, *)| data }
        end
      end
    end
  end
end
