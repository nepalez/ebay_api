RSpec.describe EbayAPI, ".commerce.taxonomy.get_default_category_tree_id" do
  let(:client) { described_class.new(settings) }
  let(:scope) { client.commerce.taxonomy }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:url) do
    "https://api.ebay.com/commerce/taxonomy/v1/get_default_category_tree_id?marketplace_id=EBAY_AT"
  end

  before  { stub_request(:get, url).to_return(response) }
  subject do
    scope.get_default_category_tree_id marketplace_id: "EBAY_AT"
  end

  context "success" do
    let(:response) do
      open_fixture_file "commerce/taxonomy/get_default_category_tree_id/success"
    end

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end
  end
end
