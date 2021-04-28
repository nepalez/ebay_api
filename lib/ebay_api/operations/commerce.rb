#
# Commerce API
#
class EbayAPI
  scope :commerce do
    path "commerce"

    require_relative "commerce/taxonomy"
  end
end
