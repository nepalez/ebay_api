class EbayAPI
  scope :sell do
    scope :account do
      scope :return_policy do
        path { "return_policy" }
      end
    end
  end
end

require_relative "return_policy/delete"
require_relative "return_policy/get"
require_relative "return_policy/get_by_name"
require_relative "return_policy/index"
require_relative "return_policy/create"
require_relative "return_policy/update"
