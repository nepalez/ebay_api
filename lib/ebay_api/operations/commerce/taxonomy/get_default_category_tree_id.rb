class EbayAPI
  scope :commerce do
    scope :taxonomy do
      operation :get_default_category_tree_id do
        http_method :get
        option :marketplace_id
        path { "get_default_category_tree_id" }
        query { { marketplace_id: marketplace_id } }
        response(200) { |_, _, (data, *)| data }
      end
    end
  end
end
