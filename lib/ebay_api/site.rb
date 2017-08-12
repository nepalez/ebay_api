class EbayAPI
  # eBay marketplace
  class Site
    extend Dry::Initializer
    option :id,         optional: true
    option :code,       proc(&:to_s)
    option :country,    proc(&:to_s)
    option :currencies, ->(v) { Array(v).uniq.map { |rec| Currency.new(rec) } }
    option :languages,  ->(v) { Array(v).uniq.map { |rec| Language.new(rec) } }
    option :host,       proc(&:to_s)

    # Compares a site to another one by its id
    # @param  [Object] other
    # @return [Boolean]
    def ==(other)
      self.class === other && id == other.id
    end

    # @return [Hash<Symbol, Object>]
    def options
      @__options__
    end

    # Enumberable collection of the eBay marketplaces
    class << self
      include Collection

      # @return [Array<EbayAPI::Site>] list of supported sites
      def all
        @all ||= begin
          old_data = YAML.load_file("config/old_sites.yml")
          YAML.load_file("config/sites.yml").flat_map do |item|
            default = { currencies: [], languages: [] }
            item[:ids].map do |id|
              obj = old_data[id]
              default[:currencies].concat obj[:currencies]
              default[:languages].concat  obj[:languages]
              new id: id, **item.merge(obj)
            end << new(item.merge(default))
          end
        end
      end

      # Finds a site by either its id, or code
      # @param  [#to_s] value The value of id or code
      # @return [EbayAPI::Site] if site supported
      # @raise  [StandardError] if site not supported
      def call(value)
        find do |site|
          (Integer === value)  && (site.id == value) ||
          (site.code == value) && (site.id.nil?)
        end || raise("Site #{value} not supported by eBay API")
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
