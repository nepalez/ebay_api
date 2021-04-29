RSpec.describe EbayAPI, ".commerce.notifications.public_key.get" do
  let(:client) { described_class.new(settings) }
  let(:scope) { client.commerce.notifications.public_key }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:url) do
    "https://api.ebay.com/commerce/notifications/v1/public_key/042"
  end

  before  { stub_request(:get, url).to_return(response) }
  subject { scope.get key_id: "042" }

  context "success" do
    let(:response) do
      open_fixture_file "commerce/notifications/public_key/get/success"
    end

    let(:public_key) do
      yaml_fixture_file "commerce/notifications/public_key/get/success.yml"
    end

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end

    it "returns the policy" do
      expect(subject).to eq public_key
    end
  end
end
