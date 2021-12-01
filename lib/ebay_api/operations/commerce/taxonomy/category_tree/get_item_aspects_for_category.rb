class EbayAPI
  scope :commerce do
    scope :taxonomy do
      scope :category_tree do
        # @see https://developer.ebay.com/api-docs/commerce/taxonomy/resources/category_tree/methods/getItemAspectsForCategory
        operation :get_item_aspects_for_category do
          option :category_id, proc(&:to_s)

          path { "get_item_aspects_for_category" }
          query { { category_id: category_id } }
          http_method :get
        end
      end
    end
  end
end
