RSpec.describe EbayAPI, "instantiation" do
  subject(:client) { described_class.new(params) }
  let(:settings)   { client.settings }

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
      expect { subject }.to raise_error(Evil::Client::ValidationError, /token/)
    end
  end

  context "without sandbox option" do
    let(:params) { { token: "foobar" } }

    it "sets sandbox to false" do
      expect(settings.sandbox).to eq false
    end
  end

  context "with sandbox option" do
    let(:params) { { token: "foobar", sandbox: 1 } }

    it "sets sandbox to true" do
      expect(settings.sandbox).to eq true
    end
  end

  context "without gzip option" do
    let(:params) { { token: "foobar" } }

    it "sets gzip to false" do
      expect(settings.gzip).to eq false
    end
  end

  context "with gzip option" do
    let(:params) { { token: "foobar", gzip: 1 } }

    it "sets gzip to true" do
      expect(settings.gzip).to eq true
    end
  end

  context "without charset option" do
    let(:params) { { token: "foobar" } }

    it "sets charset" do
      expect(settings.charset).to be_a EbayAPI::Charset
      expect(settings.charset).to eq "utf-8"
    end
  end

  context "with valid charset option" do
    let(:params) { { token: "foobar", charset: "Windows-1251" } }

    it "sets charset" do
      expect(settings.charset).to be_a EbayAPI::Charset
      expect(settings.charset).to eq "windows-1251"
    end
  end

  context "with invalid charset option" do
    let(:params) { { token: "foobar", charset: "WTF" } }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(Evil::Client::ValidationError, /WTF/)
    end
  end

  context "with valid language option" do
    let(:params) { { token: "foobar", language: "zh-HK" } }

    it "sets language" do
      expect(settings.language).to be_a EbayAPI::Language
      expect(settings.language).to eq "zh-HK"
    end
  end

  context "with invalid language option" do
    let(:params) { { token: "foobar", language: "zh-RU" } }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(Evil::Client::ValidationError, /zh-RU/)
    end
  end

  context "with valid site id" do
    let(:params) { { token: "foobar", site: 15 } }

    it "sets site" do
      expect(settings.site).to be_a EbayAPI::Site
      expect(settings.site.code).to eq "EBAY-AU"
    end
  end

  context "with valid site code" do
    let(:params) { { token: "foobar", site: "EBAY-AU" } }

    it "sets site" do
      expect(settings.site).to be_a EbayAPI::Site
      expect(settings.site.code).to eq "EBAY-AU"
    end
  end

  context "with invalid site id option" do
    let(:params) { { token: "foobar", site: 9823 } }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(Evil::Client::ValidationError, /9823/)
    end
  end

  context "when language not supported by site" do
    let(:params) { { token: "foobar", language: "zh-CN", site: 215 } }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(Evil::Client::ValidationError, /zh-CN/)
    end
  end
end
