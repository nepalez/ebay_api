RSpec.describe EbayAPI::Charset do
  subject(:version) { described_class[value] }
  let(:value) { "UTF-8" }

  context "when charset is supported" do
    it { is_expected.to eq "utf-8" }
  end

  context "when charset is not supported" do
    let(:value) { "WTF" }

    it "raises ArgumentError" do
      expect { subject }.to raise_error ArgumentError
    end
  end

  context "initialized charset" do
    let(:value) { described_class["utf-8"] }
    it { is_expected.to eql value }
  end
end
