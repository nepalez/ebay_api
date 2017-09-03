RSpec.describe EbayAPI, ".sell.inventory.offer.get_listing_fees" do
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.inventory(version: version).offers }
  let(:response) { yaml_fixture_file(response_file).to_json }
  let(:request)  { yaml_fixture_file(request_file).to_json }
  let(:settings) { yaml_fixture_file(settings_file) }

  let(:version)       { "1.1.0" }
  let(:settings_file) { "settings.valid.yml" }
  let(:request_file)  { "sell/inventory/offers/get_listing_fees/request.yml" }
  let(:response_file) { "sell/inventory/offers/get_listing_fees/response.yml" }

  before  { stub_request(:any, //).to_return(body: response) }
  subject { scope.get_listing_fees offer_ids: %w(36445435465 36445435466) }

  context "with valid data:" do
    let(:url) do
      "https://api.ebay.com/sell/inventory/v1/offer/get_listing_fees"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url).with(body: request)).to have_been_made
    end

    it "returns parsed response" do
      expect(subject).to eq JSON.parse(response)
    end
  end
end
