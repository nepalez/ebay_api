RSpec.describe EbayAPI::ProgramType do
  describe "#call, #[]" do
    subject(:program_type) { described_class[key] }

    context "by known key" do
      let(:key) { :out_of_stock_control }

      it "finds the type" do
        expect(subject).to eq "OUT_OF_STOCK_CONTROL"
      end
    end

    context "by unknown key" do
      let(:key) { "AAA" }

      it "raises ArgumentError" do
        expect { subject }.to raise_error(StandardError, /AAA/)
      end
    end
  end
end
