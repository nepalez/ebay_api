RSpec.describe EbayAPI::Tax do
  let(:source)    { { applyTax: "true", vatPercentage: "0.2381" } }
  subject(:model) { described_class[source] }

  it "builds the record" do
    expect(model.apply_tax).to eq true
    expect(model.vat).to eq 0.238
  end

  it "hashifies data properly" do
    expect(model.to_h).to eq applyTax: true, vatPercentage: 0.238
  end

  context "when applyTax option not set" do
    before { source.delete :applyTax }

    it "applies the tax" do
      expect(model.apply_tax).to eq true
    end
  end

  context "when vat is not set" do
    before { source.delete :vatPercentage }

    it "raises StandardError" do
      expect { model }
        .to raise_error StandardError, /vatPercentage/
    end
  end

  context "when vat is negative" do
    before { source[:vatPercentage] = -1 }

    it "raises StandardError" do
      expect { model }
        .to raise_error StandardError, /vatPercentage/
    end
  end

  context "when vat is greater than 100" do
    before { source[:vatPercentage] = 100.001 }

    it "raises StandardError" do
      expect { model }
        .to raise_error StandardError, /vatPercentage/
    end
  end
end
