RSpec.describe EbayAPI, ".sell.marketing.campaign.create" do
  let(:url) { "https://api.ebay.com/sell/marketing/v1/ad_campaign" }
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.marketing(version: version).campaigns }
  let(:settings) { yaml_fixture_file(settings_file) }
  let(:version)       { "1.1.0" }
  let(:settings_file) { "settings.valid.yml" }
  let(:params) do
    {
      "campaignName" => "eBay Mag GB",
      fundingStrategy: {
          "bidPercentage" => "5.0",
          "fundingModel"  => "COST_PER_SALE",
      },
      "marketplaceId": "EBAY_GB",
      startDate: Time.now.iso8601
    }
  end

  before  { stub_request(:post, url).to_return(response) }
  subject { scope.create(campaign: params) }

  context "successful creation" do
    let(:response) do
      open_fixture_file "sell/marketing/campaigns/create_campaign/success"
    end

    it do
      expect(subject).to \
        eq "https://api.ebay.com/sell/marketing/v1/ad_campaign/10210720017"
    end
  end

  context "when campaign with the same name already exists" do
    let(:response) do
      open_fixture_file "sell/marketing/campaigns/create_campaign/35051-market"
    end

    it do
      expect { subject }.to raise_error(EbayAPI::Error) do |ex|
        expect(ex.code).to eq 35051
        expect(ex.message).to match /'marketplaceId' EBAY_FR is not supported\./
      end
    end
  end

  context "when end user didn't accepted terms" do
    let(:response) do
      open_fixture_file "sell/marketing/campaigns/create_campaign/35067-terms"
    end

    it "raises exception to application to urge user to visit URL" do
      expect { subject }.to raise_error(EbayAPI::UserActionRequired) do |error|
        expect(error.code).to eq 35067
        expect(error.url).to eq "http://www.ebay.co.uk/pl/agreement"
      end
    end
  end

  context "when unsupported marketplace used" do
    let(:response) do
      open_fixture_file "sell/marketing/campaigns/create_campaign/35051-market"
    end

    it do
      expect { subject }.to raise_error(EbayAPI::Error) do |ex|
        expect(ex.code).to eq 35051
        expect(ex.message).to match /'marketplaceId' EBAY_FR is not supported\./
      end
    end
  end
end
