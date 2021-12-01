class EbayAPI
  scope :commerce do
    scope :taxonomy do
      scope :category_tree do
        # @see https://developer.ebay.com/api-docs/commerce/taxonomy/resources/category_tree/methods/getCategorySubtree
        operation :get_category_subtree do
          option :category_id, proc(&:to_s)

          path { "get_category_subtree" }
          query { { category_id: category_id } }
          http_method :get
        end
      end
    end
  end
end
