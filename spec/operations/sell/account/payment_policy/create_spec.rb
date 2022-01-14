RSpec.describe EbayAPI, ".sell.account.payment_policy.create" do
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.account(version: version).payment_policy }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:version)  { "1.2.0" }

  let(:url) do
    "https://api.ebay.com/sell/account/v1/payment_policy/"
  end

  let(:payload) do
    yaml_fixture_file "sell/account/payment_policy/create/request.yml"
  end

  let(:data) do
    payload.reject { |key| key == "marketplaceId" }
  end

  before  { stub_request(:post, url).with(body: payload).to_return(response) }
  subject { scope.create site: 0, data: data }

  context "success" do
    let(:response) do
      open_fixture_file "sell/account/payment_policy/create/success"
    end

    let(:policy) do
      yaml_fixture_file "sell/account/payment_policy/create/success.yml"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns the policy" do
      expect(subject).to eq policy
    end
  end
end
