require_relative "../models/version"

class EbayApi::UnknownApiError < ArgumentError
  private

  def initialize(wrong_group, wrong_name)
    title = "#{wrong_group}.#{wrong_name}"
    known = EbayApi::Version::SUPPORTED
           .flat_map { |group, list| list.keys.map { |key| "#{group}.#{key}" } }
           .join(", ")

    super "API '#{title}' is unknown. Use one of the following names: #{known}."
  end
end
