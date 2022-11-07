RSpec.describe EbayAPI, ".sell.account.subscription.get" do
  let(:client)        { described_class.new(settings) }
  let(:scope)         { client.sell.account(version: version).subscription }
  let(:settings)      { yaml_fixture_file(settings_file) }
  let(:version)       { "1.2.0" }
  let(:settings_file) { "settings.valid.yml" }
  let(:url)  do
    "https://api.ebay.com/sell/account/v1/subscription/" \
      "?limit=10&continuation_token=some_token"
  end

  before  { stub_request(:get, url).to_return(response) }
  subject { scope.get limit: 10, continuation_token: "some_token" }

  context "success" do
    let(:response) do
      open_fixture_file "sell/account/subscription/get/success"
    end

    let(:policy) do
      yaml_fixture_file \
        "sell/account/subscription/get/success.yml"
    end

    it "returns just parsed JSON with data about subscription" do
      expect(subject).to eq(policy)
    end
  end

  context "bad request" do
    let(:response) do
      open_fixture_file "sell/account/subscription/get/bad_request"
    end

    it "raises an exception" do
      expect { subject }.to raise_error EbayAPI::Error
    end

    it "carries error message" do
      subject
    rescue => err
      expect(err.code).to eq 1002
      expect(err.data).not_to be_empty
    end
  end

  context "server error" do
    let(:response) do
      open_fixture_file "sell/account/subscription/get/server_error"
    end

    it "raises an exception" do
      expect { subject }.to raise_error EbayAPI::Error
    end
  end
end
