class EbayAPI
  # eBay marketplace
  class Site
    extend Dry::Initializer
    option :id,         optional: true
    option :code,       proc(&:to_s)
    option :country,    proc(&:to_s)
    option :host,       proc(&:to_s)
    option :currencies, ->(v) { Array(v).uniq.map { |rec| Currency.new(rec) } }
    option :languages,  ->(v) { Array(v).uniq.map { |rec| Language.new(rec) } }

    # Representation of the site
    def to_s
      I18n.t(code, scope: %i[evil client sites])
    end

    # Compares a site to another one by its id
    # @param  [Object] other
    # @return [Boolean]
    def ==(other)
      self.class === other && id == other.id
    end

    # @return [Hash<Symbol, Object>]
    def options
      @options ||= self.class.dry_initializer.attributes(self)
    end

    # @param  [EbayAPI::Site]
    # @return [EbayAPI::Site]
    def merge(other)
      self.class.new code:       code,
                     country:    country,
                     host:       host,
                     currencies: currencies | other.currencies,
                     languages:  languages  | other.languages
    end

    # Enumberable collection of the eBay marketplaces
    class << self
      include Collection
      include Callable

      # @return [Array<EbayAPI::Site>] list of supported sites
      def all
        @all ||= YAML.load_file("config/sites.yml").map { |item| new(item) }
      end

      # Finds a site by either its id, or code
      # @param  [#to_s] value The value of id or code
      # @return [EbayAPI::Site] if site supported
      # @raise  [StandardError] if site not supported
      def call(value)
        return value if value.instance_of?(self)
        value = value.to_s.gsub("_", "-")

        site = if value[/^\d+$/]
                 find { |item| item.id.to_s == value }
               else
                 select { |item| item.code == value }.inject(:merge)
               end

        site || raise("Site #{value} not supported by eBay API")
      end

      # @return [Array<EbayApi::Language>] list of supported languages
      def languages
        flat_map(&:languages).uniq.sort
      end

      # @return [Array<EbayApi::Currency>] list of supported curencies
      def currencies
        flat_map(&:currencies).uniq.sort
      end
    end
  end
end
