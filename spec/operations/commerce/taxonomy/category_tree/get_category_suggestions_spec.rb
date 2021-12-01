RSpec.describe EbayAPI, ".commerce.taxonomy.category_tree.get_category_suggestions" do
  let(:client) { described_class.new(settings) }
  let(:scope) { client.commerce.taxonomy.category_tree(category_tree_id: 41) }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:url) do
    "https://api.ebay.com/commerce/taxonomy/v1/category_tree/41/get_category_suggestions?q=android"
  end

  before  { stub_request(:get, url).to_return(response) }
  subject do
    scope.get_category_suggestions query: "android"
  end

  context "success" do
    let(:response) do
      open_fixture_file "commerce/taxonomy/category_tree/get_category_suggestions/success"
    end

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end
  end
end
