RSpec.describe EbayAPI, ".sell.account.payment_policy.update" do
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.account(version: version).payment_policy }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:version)  { "1.2.0" }

  let(:url) do
    "https://api.ebay.com/sell/account/v1/payment_policy/184528067024"
  end

  let(:payload) do
    yaml_fixture_file "sell/account/payment_policy/update/request.yml"
  end

  let(:data) do
    payload.reject { |key| key == "marketplaceId" }
  end

  before  { stub_request(:put, url).to_return(response) }
  subject { scope.update id: "184528067024", site: 0, data: data }

  context "success" do
    let(:response) do
      open_fixture_file "sell/account/payment_policy/update/success"
    end

    let(:policy) do
      yaml_fixture_file "sell/account/payment_policy/update/success.yml"
    end

    it "sends a request" do
      subject
      expect(a_request(:put, url)).to have_been_made
    end

    it "returns the policy" do
      expect(subject).to eq policy
    end
  end
end
