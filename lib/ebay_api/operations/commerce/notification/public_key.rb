class EbayAPI
  scope :commerce do
    scope :notifications do
      scope :public_key do
        path "public_key"

        require_relative "public_key/get"
      end
    end
  end
end
