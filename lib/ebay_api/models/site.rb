class EbayAPI
  # eBay marketplace
  class Site
    extend Dry::Initializer
    option :code,       proc(&:to_s), optional: true
    option :key,        proc(&:to_s), optional: true
    option :country,    proc(&:to_s), optional: true
    option :host,       proc(&:to_s), optional: true
    option :id,         proc(&:to_i), optional: true
    option :currencies,
           ->(v) { Array(v).uniq.map { |rec| Currency[rec] } },
           optional: true
    option :languages,
           ->(v) { Array(v).uniq.map { |rec| Language.new(rec) } },
           optional: true

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
                     key:        key,
                     currencies: currencies | other.currencies,
                     languages:  languages  | other.languages
    end

    # Enumberable collection of the eBay marketplaces
    class << self
      sites_file = File.join(GEM_ROOT, %w[config sites.yml])
      include Evil::Client::Dictionary[sites_file]

      # Finds a site by either its id, or code
      # @param  [#to_s] item The value of id or code
      # @return [EbayAPI::Site] if site supported
      # @raise  [StandardError] if site not supported
      def call(item)
        list = [item] if item.instance_of?(self)
        item = item.to_s
        list ||= select { |rec| [rec.code, rec.key, rec.id.to_s].include? item }
        list.inject(:merge) || super
      end

      # @return [Array<EbayApi::Language>] list of supported languages
      def languages
        flat_map(&:languages).uniq.sort
      end

      # @return [Array<EbayApi::Currency>] list of supported curencies
      def currencies
        flat_map(&:currencies).uniq.sort.map { |item| Currency[item] }
      end
    end
  end
end
