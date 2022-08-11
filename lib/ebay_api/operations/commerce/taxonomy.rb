class EbayAPI
  scope :commerce do
    #
    # eBay Commerce Taxonomy API
    #
    # @see https://developer.ebay.com/api-docs/commerce/taxonomy/overview.html
    #
    scope :taxonomy do
      path { "taxonomy/v#{EbayAPI::COMMERCE_TAXONOMY_VERSION[/^\d+/]}" }

      require_relative "taxonomy/category_tree"
      require_relative "taxonomy/get_default_category_tree_id"
    end
  end
end
