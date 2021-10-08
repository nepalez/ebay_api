class EbayAPI
  scope :commerce do
    scope :taxonomy do
      # @see https://developer.ebay.com/api-docs/commerce/taxonomy/resources/category_tree/methods/getDefaultCategoryTreeId
      operation :get_default_category_tree_id do
        option :marketplace_id, proc(&:to_s)

        path { "get_default_category_tree_id" }
        query { { marketplace_id: marketplace_id } }
        http_method :get
      end
    end
  end
end
