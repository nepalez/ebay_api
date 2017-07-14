require "spec_helper"

RSpec.describe EbayApi::Language do
  subject(:language) { described_class[key] }

  context "by known key" do
    let(:key) { :"zh-HK" }
    it { is_expected.to eq "zh-HK" }
  end

  context "by unknown key" do
    let(:key) { :"zh-RU" }

    it "raises ArgumentError" do
      expect { subject }.to raise_error(ArgumentError, /zh-RU/)
    end
  end
end
