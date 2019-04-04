class EbayAPI
  scope :sell do
    scope :inventory do
      scope :offers do
        operation :create do
          option :content_language
          option :data
          http_method :post
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
