RSpec.describe EbayAPI, ".commerce.media.video.get" do
  let(:client) { described_class.new(settings) }
  let(:scope) { client.commerce.media.video }
  let(:settings) { yaml_fixture_file("settings.valid.yml").merge(api_subdomain: "apim") }
  let(:video_id) { "92626cdc1820ab8eac2356d1ffffe6d0" }
  let(:url) do
    "https://apim.ebay.com/commerce/media/v1_beta/video/#{video_id}"
  end

  before  { stub_request(:get, url).to_return(response) }

  subject do
    scope.get(id: video_id)
  end

  context "success" do
    let(:response) do
      open_fixture_file "commerce/media/video/get/success"
    end

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end
  end
end
