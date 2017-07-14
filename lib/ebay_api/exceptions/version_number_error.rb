require_relative "../models/version"

class EbayApi::VersionNumberError < ArgumentError
  private

  def initialize(group, name, wrong_number)
    title = "#{group}.#{name}"
    known = EbayApi::Version::SUPPORTED.dig(group.to_s, name.to_s)
                                       .map { |item| item["number"] }
                                       .join(", ")

    super "Version '#{wrong_number}' of the API #{title} is not supported." \
          " Select one of the following versions: #{known} (default)."
  end
end
