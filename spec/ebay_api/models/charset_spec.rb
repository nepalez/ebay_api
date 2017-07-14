require "spec_helper"

RSpec.describe EbayApi::Charset do
  subject(:version) { described_class[value] }
  let(:value) { "UTF-8" }

  context "when charset is supported" do
    it { is_expected.to eq "utf-8" }
  end

  context "when charset is supported" do
    let(:value) { "WTF" }

    it "raises ArgumentError" do
      expect { subject }.to raise_error ArgumentError
    end
  end
end
