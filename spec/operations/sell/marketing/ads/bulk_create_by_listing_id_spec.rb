RSpec.describe EbayAPI, ".sell.marketing.ads.bulk_create_by_listing_id" do
  let(:url) do
    <<~URL.strip
      https://api.ebay.com/sell/marketing/v1/ad_campaign/1/bulk_create_ads_by_listing_id
    URL
  end
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.marketing(version: version).ads(campaign_id: 1) }
  let(:settings) { yaml_fixture_file(settings_file) }
  let(:version)       { "1.1.0" }
  let(:settings_file) { "settings.valid.yml" }
  let(:params)   { [{ listing_id: "222231499902", bid: "1.0" }] }
  let(:req_body) do
    '{"requests":[{"listingId":"222231499902","bidPercentage":"1.0"}]}'
  end

  before  { stub_request(:post, url).with(body: req_body).to_return(response) }
  subject { scope.bulk_create_by_listing_id(ad_requests: params) }

  context "successful creation" do
    let(:response) do
      open_fixture_file "sell/marketing/ads/bulk_create_by_listing_id/success"
    end

    it do
      expect(subject).to eq \
        [{
          "statusCode" => 201, "listingId" => "322946981233", "adId" => "8",
          "href" => "https://api.ebay.com/sell/marketing/v1/ad_campaign/1/ad/8"
        }]
    end
  end

  context "with wrong param naming" do
    let(:params) { [{ listing_id: "222231499902", bid_percentage: "1.0" }] }
    let(:req_body) do
      '{"requests":[{"listingId":"222231499902","bidPercentage":null}]}'
    end
    let(:response) do
      open_fixture_file "sell/marketing/ads/bulk_create_by_listing_id/invalid"
    end

    it do
      expect { subject }.to raise_error(EbayAPI::Error) do |ex|
        expect(ex.code).to eq 35_007
        expect(ex.message).to match \
          /The 'bidPercentage' null is not valid/
      end
    end
  end

  context "when requested listing belongs to another seller" do
    let(:response) do
      open_fixture_file "sell/marketing/ads/bulk_create_by_listing_id/not-found"
    end

    it do
      expect(subject).to contain_exactly \
        include(
          "statusCode" => 404, "listingId" => "32294698123434",
          "errors" => contain_exactly(include(
            "errorId" => 35_048,
            "message" => "The listing Id 123 is invalid or has ended."
          ))
        )
    end
  end
end
