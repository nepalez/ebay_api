RSpec.describe EbayAPI, ".sell.marketing.ads.create_by_listing_id" do
  let(:url) { "https://api.ebay.com/sell/marketing/v1/ad_campaign/1/ad" }
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.marketing(version: version).ads(campaign_id: 1) }
  let(:settings) { yaml_fixture_file(settings_file) }
  let(:version)       { "1.1.0" }
  let(:settings_file) { "settings.valid.yml" }
  let(:params)   { { listing_id: "222231499902", bid_percentage: "1.0" } }

  before  { stub_request(:post, url).to_return(response) }
  subject { scope.create_by_listing_id(**params) }

  context "successful creation" do
    let(:response) do
      open_fixture_file "sell/marketing/ads/create_by_listing_id/success"
    end

    it do
      expect(subject).to eq \
        "https://api.ebay.com/sell/marketing/v1/ad_campaign/1/ad/5"
    end
  end

  context "when requested listing belongs to another seller" do
    let(:response) do
      open_fixture_file "sell/marketing/ads/create_by_listing_id/35057-seller"
    end

    it do
      expect { subject }.to raise_error(EbayAPI::Error) do |ex|
        expect(ex.code).to eq 35_057
        expect(ex.message).to match \
          /The listing Id 222231499902 does not belong to the seller/
      end
    end
  end
end
