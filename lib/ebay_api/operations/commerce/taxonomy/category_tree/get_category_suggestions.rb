class EbayAPI
  scope :commerce do
    scope :taxonomy do
      scope :category_tree do
        # @see https://developer.ebay.com/api-docs/commerce/taxonomy/resources/category_tree/methods/getCategorySuggestions
        operation :get_category_suggestions do
          option :query, proc(&:to_s)

          path { "get_category_suggestions" }
          query { { q: query } }
          http_method :get
        end
      end
    end
  end
end
