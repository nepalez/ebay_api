require_relative "callable"

# Describes eBay marketplace
class EbayApi::Site
  extend EbayApi::Callable

  # @param  [#to_s] code_or_id
  # @return [EbayApi::Site]
  def self.new(id)
    data = SUPPORTED.find { |item| item["id"] == id.to_i }
    raise EbayApi::UnknownSiteError.new(id) unless data
    super data
  end

  attr_reader :id, :code, :country, :currencies, :host, :languages

  private

  def initialize(data)
    @id         = data["id"]
    @code       = data["code"]
    @country    = data["country"]
    @currencies = data["currencies"]
    @host       = data["host"]
    @languages  = data["languages"]
  end

  SUPPORTED = YAML.load_file("config/sites.yml").freeze
end
