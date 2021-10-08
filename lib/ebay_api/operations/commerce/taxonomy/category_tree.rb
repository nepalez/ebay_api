class EbayAPI
  scope :commerce do
    #
    # eBay Commerce Notifications API
    #
    # @see https://developer.ebay.com/api-docs/commerce/taxonomy/overview.html
    #
    scope :taxonomy do
      scope :category_tree do
        path { "category_tree/#{category_tree_id}" }
        option :category_tree_id

        require_relative "category_tree/get"
        require_relative "category_tree/get_category_subtree"
        require_relative "category_tree/get_category_suggestions"
        require_relative "category_tree/get_item_aspects_for_category"
        require_relative "category_tree/fetch_item_aspects"
      end
    end
  end
end
