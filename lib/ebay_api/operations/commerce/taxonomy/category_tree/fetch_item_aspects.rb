class EbayAPI
  scope :commerce do
    scope :taxonomy do
      scope :category_tree do
        # @see https://developer.ebay.com/api-docs/commerce/taxonomy/resources/category_tree/methods/fetchItemAspects
        operation :fetch_item_aspects do
          middleware { SaveToFileResponse } # returns { "filename": "..." }

          path { "fetch_item_aspects" }
          http_method :get
        end
      end
    end
  end
end
