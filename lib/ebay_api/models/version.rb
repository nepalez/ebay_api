require_relative "callable"

class EbayApi::Version
  extend EbayApi::Callable

  def self.new(group, name, number = nil)
    api = SUPPORTED.dig group.to_s, name.to_s
    raise EbayApi::UnknownApiError.new(group, name) unless api

    data = number ? api.find { |d| d["number"] == number.to_s } : api.last
    raise EbayApi::VersionNumberError.new(group, name, number) unless data

    super group, name, data
  end

  attr_reader :group, :name, :number, :primary

  private

  def initialize(group, name, data)
    @group   = group.to_s
    @name    = name.to_s
    @number  = data["number"].to_s
    @primary = number.split(".").first
  end

  SUPPORTED = YAML.load_file("config/versions.yml").freeze
end
