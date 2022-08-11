RSpec.describe EbayAPI, ".commerce.media.video.create" do
  let(:client) { described_class.new(settings) }
  let(:scope) { client.commerce.media.video }
  let(:settings) { yaml_fixture_file("settings.valid.yml").merge(api_subdomain: "apim") }
  let(:url) do
    "https://apim.ebay.com/commerce/media/v1_beta/video/"
  end
  let(:payload) do
    {
      "size": 3_114_374,
      "title": "Test video",
      "description": "Test video description"
    }
  end

  before  { stub_request(:post, url).to_return(response) }

  subject do
    scope.create(payload: payload)
  end

  context "success" do
    let(:response) do
      open_fixture_file "commerce/media/video/create/success"
    end

    it "sends a request" do
      expect(subject).to eq({ "id" => "92626cdc1820ab8eac2356d1ffffe6d0" })
      expect(a_request(:post, url)).to have_been_made
    end
  end
end
