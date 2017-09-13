RSpec.describe EbayAPI::Currency do
  describe "#call, #[]" do
    subject(:currency) { described_class[key] }

    context "by known key" do
      let(:key) { :rub }

      it "finds currency" do
        expect(subject.code).to eq "RUB"
      end
    end

    context "by unknown key" do
      let(:key) { "AAA" }

      it "raises ArgumentError" do
        expect { subject }.to raise_error(StandardError, /AAA/)
      end
    end

    context "initialized currency" do
      let(:key) { described_class["RUB"] }
      it { is_expected.to eql key }
    end
  end
end
