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
      body = StringIO.new
      gzipper = Zlib::GzipWriter.new(body)
      gzipper.write(read_fixture_file("commerce/taxonomy/category_tree/fetch_item_aspects/success.json"))
      gzipper.close

      {
        status: 200,
        body: body.string,
      }
    end

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end
  end
end
