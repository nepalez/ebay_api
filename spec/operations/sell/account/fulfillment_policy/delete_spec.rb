RSpec.describe EbayAPI, ".sell.account.fulfillment_policy.delete" do
  let(:url) { "https://api.ebay.com/sell/account/v1/fulfillment_policy/42" }
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.account(version: version).fulfillment_policy }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:version)  { "1.2.0" }

  before  { stub_request(:delete, url).to_return(status: 204) }
  subject { scope.delete id: 42 }

  context "success" do
    it "sends a request" do
      subject
      expect(a_request(:delete, url)).to have_been_made
    end

    it "returns true" do
      expect(subject).to eq true
    end
  end
end
