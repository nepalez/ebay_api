RSpec.describe EbayAPI, ".sell.marketing.ads.bulk_delete_by_listing_id" do
  let(:url) do
    <<~URL.strip
      https://api.ebay.com/sell/marketing/v1/ad_campaign/1/bulk_delete_ads_by_listing_id
    URL
  end
  let(:client)   { described_class.new(settings) }
  let(:scope)    { client.sell.marketing(version: version).ads(campaign_id: 1) }
  let(:settings) { yaml_fixture_file(settings_file) }
  let(:version)  { "1.1.0" }
  let(:settings_file) { "settings.valid.yml" }
  let(:params) { %w[222372324170 222214540024] }
  let(:request_body) do
    '{"requests":[{"listingId":"222372324170"},{"listingId":"222214540024"}]}'
  end

  before do
    stub_request(:post, url).with(body: request_body).to_return(response)
  end

  subject { scope.bulk_delete_by_listing_id(listing_ids: params) }

  context "successful deletion" do
    let(:response) do
      open_fixture_file "sell/marketing/ads/bulk_delete_by_listing_id/success"
    end

    it do
      expect(subject).to eq \
        [{
           "statusCode" => 200,
           "listingId" => "322946981233",
           "adId" => "81927927018"
        }]
    end
  end

  context "when requested listing belongs to another seller" do
    let(:response) do
      open_fixture_file "sell/marketing/ads/bulk_delete_by_listing_id/not-found"
    end

    it do
      expect(subject).to contain_exactly \
        include(
          "statusCode" => 404, "listingId" => "222372324170",
          "errors" => contain_exactly(include(
            "errorId" => 35044,
            "message" => match(/No Ad found for 'ad_id'/)
          )),
        ),
        include(
          "statusCode" => 404, "listingId" => "222214540024",
          "errors" => contain_exactly(include(
            "errorId" => 35044,
            "message" => match(/No Ad found for 'ad_id'/)
          ))
        )
    end
  end
end
