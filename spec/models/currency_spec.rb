RSpec.describe EbayAPI::Currency do
  describe "#call, #[]" do
    subject(:currency) { described_class[key] }

    context "by known key" do
      let(:key) { :RUB }
      it { is_expected.to eq "RUB" }
    end

    context "by unknown key" do
      let(:key) { :UAH }

      it "raises ArgumentError" do
        expect { subject }.to raise_error(StandardError, /UAH/)
      end
    end

    context "initialized currency" do
      let(:key) { described_class["RUB"] }
      it { is_expected.to eql key }
    end
  end

  describe ".all" do
    subject { described_class.all }

    it "returns supported currencies" do
      expect(subject).to match_array \
        %w[AUD CAD CHF CNY EUR GBP HKD INR MYR PHP PLN RUB SGD USD]
    end
  end
end
