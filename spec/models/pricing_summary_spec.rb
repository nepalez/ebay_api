RSpec.describe EbayAPI::PricingSummary do
  let(:model) { described_class[source] }

  let(:source) do
    {
      "currency"                       => "USD",
      "price"                          => 49.99,
      "pricingVisibility"              => "PRE_CHECKOUT",
      "minimumAdvertisedPrice"         => 50.0,
      "originallySoldForRetailPriceOn" => "ON_EBAY",
      "originalRetailPrice"            => 50.01
    }
  end

  let(:target) do
    {
      price: { value: "49.99", currency: "USD" },
      pricingVisibility: "PRE_CHECKOUT",
      minimumAdvertisedPrice: { value: "50.0", currency: "USD" },
      originallySoldForRetailPriceOn: "ON_EBAY",
      originalRetailPrice: { value: "50.01", currency: "USD" }
    }
  end

  subject { model.to_h }

  context "with numerical prices" do
    it { is_expected.to eq target }
  end

  context "with hash prices" do
    before do
      source.update "price" => { "value" => "49.99", currency: "USD" },
                    "originalRetailPrice" => { value: 50.01, currency: "USD" },
                    "minimumAdvertisedPrice" => { value: "50", currency: "USD" }
    end

    it { is_expected.to eq target }
  end

  context "without price" do
    before do
      source.delete "price"
      target.delete :price
    end

    it { is_expected.to eq target }
  end

  context "without map params" do
    before do
      source.delete "minimumAdvertisedPrice"
      source.delete "pricingVisibility"
      target.delete :minimumAdvertisedPrice
      target.delete :pricingVisibility
    end

    it { is_expected.to eq target }
  end

  context "with map price only" do
    before { source.delete "pricingVisibility" }

    it "raises StandardError" do
      expect { subject }.to raise_error StandardError, /MAP/
    end
  end

  context "with map visibility only" do
    before { source.delete "minimumAdvertisedPrice" }

    it "raises StandardError" do
      expect { subject }.to raise_error StandardError, /MAP/
    end
  end

  context "with wrong visibility" do
    before { source["pricingVisibility"] = "FOO" }

    it "raises StandardError" do
      expect { subject }.to raise_error StandardError, /FOO/
    end
  end

  context "without stp params" do
    before do
      source.delete "originalRetailPrice"
      source.delete "originallySoldForRetailPriceOn"
      target.delete :originallySoldForRetailPriceOn
      target.delete :originalRetailPrice
    end

    it { is_expected.to eq target }
  end

  context "with stp price only" do
    before { source.delete "originallySoldForRetailPriceOn" }

    it "raises StandardError" do
      expect { subject }.to raise_error StandardError, /STP/
    end
  end

  context "with stp type only" do
    before { source.delete "originalRetailPrice" }

    it "raises StandardError" do
      expect { subject }.to raise_error StandardError, /STP/
    end
  end

  context "with wrong stp_type" do
    before { source["originallySoldForRetailPriceOn"] = "FOO" }

    it "raises StandardError" do
      expect { subject }.to raise_error StandardError, /FOO/
    end
  end

  context "without currency" do
    before { source.delete "currency" }

    it "raises StandardError" do
      expect { subject }
        .to raise_error StandardError, /currency/
    end
  end

  context "with wrong currency" do
    before { source["currency"] = "FOO" }

    it "raises StandardError" do
      expect { subject }.to raise_error StandardError, /FOO/
    end
  end
end
