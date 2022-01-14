RSpec.describe EbayAPI, ".sell.account.payment_policy.get_by_name" do
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.account(version: version).payment_policy }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:version)  { "1.2.0" }
  let(:url) do
    "https://api.ebay.com/sell/account/v1/payment_policy/get_by_policy_name" \
      "?marketplace_id=EBAY_US&name=Managed%20Payments"
  end

  before  { stub_request(:get, url).to_return(response) }
  subject { scope.get_by_name site: 0, name: "Managed Payments" }

  context "success" do
    let(:response) do
      open_fixture_file "sell/account/payment_policy/get_by_name/success"
    end

    let(:policy) do
      yaml_fixture_file \
        "sell/account/payment_policy/get_by_name/success.yml"
    end

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end

    it "returns the policy" do
      expect(subject).to eq policy
    end
  end
end
