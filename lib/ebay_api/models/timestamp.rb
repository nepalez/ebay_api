require "time"

class EbayAPI
  # Auxilary class to handle time values
  class Timestamp
    def self.call(v)
      new(v && v.is_a?(Time) ? v : Time.iso8601(v))
    end

    def initialize(value)
      @value = value
    end

    def to_s
      @value&.utc&.iso8601(3)
    end
    alias_method :to_hash, :to_s
  end
end
