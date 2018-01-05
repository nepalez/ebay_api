RSpec.describe EbayAPI, ".sell.marketing.ads.list" do
  let(:url) do
    Addressable::Template.new <<~URL.strip
      https://api.ebay.com/sell/marketing/v1/ad_campaign/1/ad{?params*}
    URL
  end
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.marketing(version: version).ads(campaign_id: 1) }
  let(:settings) { yaml_fixture_file(settings_file) }
  let(:version)  { "1.1.0" }
  let(:settings_file) { "settings.valid.yml" }
  let(:params)   { {} }
  before do
    r = response
    stub_request(:get, url).to_return do |request|
      uri = Addressable::URI.parse(request.uri)
      offset = uri.query_values&.fetch("offset", nil)
      r[offset.to_i]
    end
  end

  subject { scope.list(**params).to_a }

  context "success" do
    let(:response) do
      [
        open_fixture_file("sell/marketing/ads/list/success-p1"),
        open_fixture_file("sell/marketing/ads/list/success-p2")
      ]
    end

    context "without params" do
      let(:result) do
        [
          { "adId" => "5018", "bidPercentage" => "5.3", "listingId" => "2423" },
          { "adId" => "5019", "bidPercentage" => "5.4", "listingId" => "2424" }
        ]
      end

      it { is_expected.to eq result }
    end

    context "with limit" do
      let(:params) { { limit: 1 } }

      let(:result) do
        [{ "adId" => "5018", "bidPercentage" => "5.3", "listingId" => "2423" }]
      end

      it { is_expected.to eq result }
    end

    context "with offset" do
      let(:params) { { offset: 1 } }

      let(:result) do
        [{ "adId" => "5019", "bidPercentage" => "5.4", "listingId" => "2424" }]
      end

      it { is_expected.to eq result }
    end
  end

  context "when requested ads for campaign that belongs to another seller" do
    let(:response) do
      [open_fixture_file("sell/marketing/ads/list/not-found")]
    end

    it do
      expect { subject }.to raise_error(EbayAPI::Error) do |ex|
        expect(ex.code).to eq 35_045
        expect(ex.message).to match \
          /No campaign found for 'campaign_id' 1/
      end
    end
  end
end
