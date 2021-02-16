require_relative "payments_program/get"

class EbayAPI
  scope :sell do
    scope :account do
      scope :payments_program do
        path { "payments_program" }
      end
    end
  end
end
