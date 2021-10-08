RSpec.describe EbayAPI, ".commerce.taxonomy.category_tree.fetch_item_aspects" do
  let(:client) { described_class.new(settings) }
  let(:scope) { client.commerce.taxonomy.category_tree(category_tree_id: 41) }
  let(:settings) { yaml_fixture_file("settings.valid.yml") }
  let(:url) do
    "https://api.ebay.com/commerce/taxonomy/v1/category_tree/41/fetch_item_aspects"
  end

  before  { stub_request(:get, url).to_return(response) }
  subject do
    scope.fetch_item_aspects
  end

  context "success" do
    let(:response) do
      open_fixture_file "commerce/taxonomy/category_tree/fetch_item_aspects/success"
    end

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end
  end
end
