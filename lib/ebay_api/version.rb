class EbayAPI
  # A version of EbayAPI (either Buy or Sell)
  class Version
    include Comparable
    extend  Dry::Initializer
    param :group,  proc(&:to_s)
    param :name,   proc(&:to_s)
    param :number, proc(&:to_s)

    # @return [Hash<Symbol, Object>]
    def options
      @__options__
    end

    # Checks equality to another version
    # @param  [Object] other
    # @return [Boolean]
    def ==(other)
      (self <=> other)&.zero?
    end

    # @return [String] representation of the version
    def to_s
      "#{group.capitalize} #{name.capitalize} API v#{number}"
    end
    alias to_str  to_s
    alias inspect to_s

    protected

    def numbers
      number.split(".").map do |num|
        num.to_f - (num[/beta/] ? 0.1 : 0) - (num[/alpha/] ? 0.2 : 0)
      end
    end

    def <=>(other)
      return unless self.class === other
      return unless [group, name] == [other.group, other.name]
      return 0 if number == other.number
      numbers.zip(other.numbers)
             .map { |a, b| a.to_f <=> b.to_f }
             .find { |x| !x.zero? } || -1
    end

    # Enumerable collection of supported API versions
    class << self
      include Collection

      # @return [Array<EbayAPI::Version>] list of supported versions
      def all
        @all ||= YAML.load_file("config/versions.yml").map do |group, data|
          data.map do |name, numbers|
            numbers.map { |number| new(group, name, number) }
          end
        end.flatten
      end

      # Finds a version group, name, and number
      # @param  [#to_s] group
      # @param  [#to_s] name
      # @param  [#to_s] number
      # @return [EbayAPI::Site] if version supported
      # @raise  [StandardError] if version not supported
      def call(*args)
        version = new(*args)
        find { |item| item == version } ||
          raise("#{version} not supported by EbayAPI")
      end

      # Curries arguments of the call
      # @param  [#to_s] group
      # @param  [#to_s] name
      # @return [Proc] a proc to build version by number
      def [](group, name)
        ->(number) { call(group, name, number) }
      end
    end
  end
end
