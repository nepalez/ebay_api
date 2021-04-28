#
# Commerce Taxonomy API
#
class EbayAPI
  scope :commerce do
    scope :taxonomy do
      path { "taxonomy/v#{EbayAPI::COMMERCE_TAXONOMY_VERSION[/^[^\.]+/]}" }
      require_relative "taxonomy/category_tree"
      require_relative "taxonomy/get_default_category_tree_id"
    end
  end
end
