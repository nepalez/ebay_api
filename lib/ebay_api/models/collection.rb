class EbayAPI
  module Collection
    include Enumerable

    def all
      raise NotImplementedError
    end

    def each
      block_given? ? all.each { |item| yield(item) } : all.to_enum
    end
  end
end
