class EbayAPI
  module Callable
    def new(value)
      value.instance_of?(self) ? value : super
    end

    def call(value)
      new(value)
    end

    def [](value)
      call(value)
    end
  end
end
