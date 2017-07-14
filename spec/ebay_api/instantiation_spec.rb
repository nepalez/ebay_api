RSpec.describe EbayApi, "instantiation" do
  subject(:client) { described_class.new(params) }
  let(:settings)   { client.settings }
  let(:base_url)   { client.base_url }

  context "with token option" do
    let(:params) { { token: "foobar" } }

    it { is_expected.to be_a described_class }

    it "builds settings properly" do
      expect(settings.token).to eq "foobar"
    end
  end

  context "without token option" do
    let(:params) { {} }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(ArgumentError, /token/)
    end
  end

  context "without sandbox option" do
    let(:params) { { token: "foobar" } }

    it "sets sandbox to false" do
      expect(settings.sandbox).to eq false
    end

    it "sets base url to production" do
      expect(base_url).to eq "https://api.ebay.com/"
    end
  end

  context "with sandbox option" do
    let(:params) { { token: "foobar", sandbox: 1 } }

    it "sets sandbox to true" do
      expect(settings.sandbox).to eq true
    end

    it "sets base url to test" do
      expect(base_url).to eq "https://api.sandbox.ebay.com/"
    end
  end

  context "without accept_gzip option" do
    let(:params) { { token: "foobar" } }

    it "sets accept_gzip to false" do
      expect(settings.accept_gzip).to eq false
    end
  end

  context "with accept_gzip option" do
    let(:params) { { token: "foobar", accept_gzip: 1 } }

    it "sets accept_gzip to true" do
      expect(settings.accept_gzip).to eq true
    end
  end

  context "without charset option" do
    let(:params) { { token: "foobar" } }

    it "sets site" do
      expect(settings.charset).to be_a EbayApi::Charset
      expect(settings.charset).to eq "utf-8"
    end
  end

  context "with valid charset option" do
    let(:params) { { token: "foobar", charset: "Windows-1251" } }

    it "sets site" do
      expect(settings.charset).to be_a EbayApi::Charset
      expect(settings.charset).to eq "windows-1251"
    end
  end

  context "with invalid charset option" do
    let(:params) { { token: "foobar", charset: "WTF" } }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(ArgumentError, /WTF/)
    end
  end

  context "with valid language option" do
    let(:params) { { token: "foobar", language: "zh-HK" } }

    it "sets language" do
      expect(settings.language).to be_a EbayApi::Language
      expect(settings.language).to eq "zh-HK"
    end
  end

  context "with invalid language option" do
    let(:params) { { token: "foobar", language: "zh-RU" } }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(ArgumentError, /zh-RU/)
    end
  end

  context "with valid site_id option" do
    let(:params) { { token: "foobar", site_id: 15 } }

    it "sets site" do
      expect(settings.site).to be_a EbayApi::Site
      expect(settings.site.code).to eq "EBAY-AU"
    end
  end

  context "with invalid site_id option" do
    let(:params) { { token: "foobar", site_id: 9823 } }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(ArgumentError, /9823/)
    end
  end
end
