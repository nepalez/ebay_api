RSpec.describe EbayAPI, ".sell.account.payments_program.get" do
  let(:url)           { "https://api.ebay.com/sell/account/v1/payments_program/EBAY_US/EBAY_PAYMENTS" }
  let(:client)        { described_class.new(settings) }
  let(:scope)         { client.sell.account(version: version).payments_program }
  let(:settings)      { yaml_fixture_file(settings_file) }
  let(:version)       { "1.2.0" }
  let(:settings_file) { "settings.valid.yml" }

  before  { stub_request(:get, url).to_return(response) }
  subject { scope.get(site: 0) }

  context "success" do
    let(:response) do
      open_fixture_file "sell/account/payments_program/get/success"
    end

    it "returns just parsed JSON with data about payments program" do
      expect(subject).to \
        eq(
          "marketplaceId" => "EBAY_US",
          "paymentProgramType" => "EBAY_PAYMENTS",
          "status" => "OPTED_IN",
          "wasPreviouslyOptedIn" => false
        )
    end
  end

  context "bad request" do
    let(:response) do
      open_fixture_file "sell/account/payments_program/get/bad_request"
    end

    it "raises an exception" do
      expect { subject }.to raise_error EbayAPI::Error
    end

    it "carries error message" do
      begin
        subject
      rescue => err
        expect(err.code).to eq 1002
        expect(err.data).not_to be_empty
      end
    end
  end

  context "server error" do
    let(:response) do
      open_fixture_file "sell/account/payments_program/get/server_error"
    end

    it "raises an exception" do
      expect { subject }.to raise_error EbayAPI::Error
    end
  end
end
