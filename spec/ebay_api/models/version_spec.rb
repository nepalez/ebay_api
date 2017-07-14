require "spec_helper"

RSpec.describe EbayApi::Version do
  subject(:version) { described_class[group, name, number] }

  let(:group)  { :sell }
  let(:name)   { :inventory }
  let(:number) { "1.1.0" }

  context "when version is supported" do
    its(:group)   { is_expected.to eq "sell" }
    its(:name)    { is_expected.to eq "inventory" }
    its(:number)  { is_expected.to eq "1.1.0" }
    its(:primary) { is_expected.to eq "1" }
  end

  context "when version number is not set" do
    it "takes default (last supported) version" do
      expect(subject.number).to eq "1.1.0"
    end
  end

  context "when version is not supported" do
    let(:number) { "0.1.0" }

    it "raises" do
      expect { subject }.to raise_error(ArgumentError, /0\.1\.0/)
    end
  end

  context "when API is unknown" do
    let(:name) { :hacking }

    it "raises" do
      expect { subject }.to raise_error(ArgumentError, /sell\.hacking/)
    end
  end
end
