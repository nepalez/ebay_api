class EbayAPI
  scope :commerce do
    scope :taxonomy do
      scope :category_tree do
        operation :get_item_aspects_for_category do
          http_method :get
          option :category_tree_id
          option :category_id
          path { "#{category_tree_id}/get_item_aspects_for_category" }
          query { { category_id: category_id } }
          response(200) { |_, _, (data, *)| data }
        end
      end
    end
  end
end
