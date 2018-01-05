RSpec.describe EbayAPI::Amount do
  let(:source)    { { value: "49.993", currency: :usd } }
  subject(:model) { described_class[source] }

  context "when currency is supported" do
    it "builds the record" do
      expect(model.value).to eq 49.99
      expect(model.currency).to eq EbayAPI::Currency["USD"]
    end

    it "hashifies data properly" do
      expect(model.to_h).to eq value: "49.99", currency: "USD"
    end
  end

  context "when currency not supported" do
    before { source[:currency] = "AAA" }

    it "raises StandardError" do
      expect { model }.to raise_error StandardError, /AAA/
    end
  end

  context "when value is negative" do
    before { source[:value] = -1 }

    it "raises StandardError" do
      expect { model }.to raise_error StandardError, /-1.0 USD/
    end
  end

  describe "#==" do
    it "returns true when both value and currency are the same" do
      expect(model).to eq described_class[value: 49.99, currency: "USD"]
    end

    it "returns true when value is different" do
      expect(model).not_to eq described_class[value: 49.98, currency: "USD"]
    end

    it "returns true when currency is different" do
      expect(model).not_to eq described_class[value: 49.99, currency: "CAD"]
    end
  end
end
