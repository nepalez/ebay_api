RSpec.describe EbayAPI::Site do
  let(:options) do
    {
      country:    "CA",
      code:       "EBAY-CA",
      host:       "www.ebay.ca",
      languages:  %w(en-CA fr-CA),
      currencies: %w(USD CAD)
    }
  end

  describe "#call, #[]" do
    subject(:version) { described_class[id] }

    context "by known id" do
      let(:id) { 2 }

      it "return a proper site" do
        expect(subject.options).to eq options.merge(id: 2, languages: ["en-CA"])
      end
    end

    context "by known code" do
      let(:id) { "EBAY-CA" }

      it "return a proper site" do
        expect(subject.options).to eq options
      end
    end

    context "by unknown id" do
      let(:id) { 500 }

      it "raises StandardError" do
        expect { subject }.to raise_error(StandardError, /500/)
      end
    end
  end

  describe "#==" do
    let(:site) { described_class["EBAY-CA"] }

    it "returns true for the same site" do
      expect(site).to eq site
    end

    it "returns true for an equal site" do
      expect(site).to eq described_class.new(options)
    end

    it "returns false for different site" do
      expect(site).not_to eq described_class[77]
    end

    it "returns false for another object" do
      expect(site).not_to eq 2
    end
  end

  describe "#to_str" do
    subject { "#{described_class[2]}" }

    it "returns the code" do
      expect(subject).to eq "Canadian"
    end
  end

  describe ".all" do
    subject { described_class.all.uniq }

    it "returns all sites" do
      expect(subject.map(&:code).uniq).to match_array %w[
        EBAY-AT EBAY-AU EBAY-BE EBAY-CA EBAY-CH EBAY-CN EBAY-DE EBAY-ES EBAY-FR
        EBAY-GB EBAY-HK EBAY-IE EBAY-IN EBAY-IT EBAY-MY EBAY-NL EBAY-PH EBAY-PL
        EBAY-SG EBAY-US EBAY-US.MOTORS
      ]
    end
  end
end
