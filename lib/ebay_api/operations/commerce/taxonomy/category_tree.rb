require_relative "category_tree/get_item_aspects_for_category"

#
# Category tree-related operations of the taxonomy API
#
class EbayAPI
  scope :commerce do
    scope :taxonomy do
      scope :category_tree do
        path "category_tree"
      end
    end
  end
end
