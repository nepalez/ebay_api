RSpec.describe EbayAPI, ".sell.account.program.opt_in" do
  let(:url)      { "https://api.ebay.com/sell/account/v1/program/opt_in" }
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.account(version: version).program }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:version)  { "1.2.0" }
  let(:request)  { { "programType" => "SELLING_POLICY_MANAGEMENT" }.to_json }

  before  { stub_request(:post, url) }
  subject { scope.opt_in program: :selling_policy_management }

  context "success" do
    let(:response) do
      open_fixture_file "sell/account/program/opt_in/success"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url).with(body: request)).to have_been_made
    end
  end
end
