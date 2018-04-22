RSpec.describe EbayAPI, "error handling" do
  let!(:operation) do
    class EbayAPI
      operation :test_error_handling do
        http_method :get
        path "sell/marketing/v1/ad_campaign"
      end
    end
  end

  let(:client)        { EbayAPI.new(yaml_fixture_file(settings_file)) }
  let(:settings_file) { "settings.valid.yml" }

  let!(:request) do
    uri = "https://api.ebay.com/sell/marketing/v1/ad_campaign"
    stub_request(:get, uri).to_return(response)
  end

  subject { client.test_error_handling }

  context "on eBay's internal server error" do
    let(:response) do
      open_fixture_file "internal_server_error"
    end

    it do
      expect { subject }.to raise_error(EbayAPI::InternalServerError) do |ex|
        expect(ex.code).to eq 2003
        expect(ex.message).to match /There was a problem with an eBay/
      end
    end
  end

  context "when daily request limit is reached" do
    let(:response) do
      open_fixture_file "too_many_requests"
    end

    it do
      expect { subject }.to raise_error(EbayAPI::RequestLimitExceeded) do |ex|
        expect(ex.code).to eq 2001
        expect(ex.message).to match /The request limit has been reached/
      end
    end
  end
end
