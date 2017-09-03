RSpec.describe EbayAPI::Version do
  describe "#call" do
    subject(:version) { described_class.call(group, name, number) }

    let(:group)  { :sell }
    let(:name)   { :inventory }
    let(:number) { "1.1.0" }

    it "returns existing version" do
      expect(subject.group).to  eq "sell"
      expect(subject.name).to   eq "inventory"
      expect(subject.number).to eq "1.1.0"
    end

    context "with nil" do
      let(:number) { nil }

      it "returns the last version" do
        expect(subject.group).to  eq "sell"
        expect(subject.name).to   eq "inventory"
        expect(subject.number).to eq "1.1.0"
      end
    end

    context "when version number is not set" do
      it "takes default (last supported) version" do
        expect(subject.number).to eq "1.1.0"
      end
    end

    context "when version is not supported" do
      let(:number) { "0.1.0" }

      it "raises" do
        expect { subject }.to raise_error(RuntimeError, /0\.1\.0/)
      end
    end

    context "when API is unknown" do
      let(:name) { :hacking }

      it "raises" do
        expect { subject }
          .to raise_error(RuntimeError, /Sell Hacking API v1\.1\.0/)
      end
    end
  end

  describe "#[]" do
    subject(:builder) { described_class[group, name] }
    let(:group)  { :sell }
    let(:name)   { :inventory }
    let(:number) { "1.1.0" }

    it "provides version builder by number" do
      expect(subject).to be_a Proc
      expect(subject.call(number))
        .to eq described_class.call(group, name, number)
    end
  end

  describe "comparison" do
    let(:a) { described_class.new "sell", "account", "1.beta_1.0" }
    let(:b) { described_class.new "sell", "account", "1.1.alpha_1" }
    let(:c) { described_class.new "sell", "account", "1.1.beta_1" }
    let(:d) { described_class.new "sell", "account", "1.1.0" }
    let(:e) { described_class.new "sell", "account", "1.1.1" }
    let(:f) { described_class.new "sell", "account", "1.2.0" }
    let(:g) { described_class.new "sell", "account", "2.0.0" }
    let(:h) { described_class.new "sell", "inventory", "2.0.0" }

    let(:unordered_list) { [b, d, c, a, f, e, g] }
    let(:ordered_list)   { [a, b, c, d, e, f, g] }

    it "compares versions of same API" do
      expect(unordered_list.sort).to eq ordered_list
    end

    it "cannot compare versions of different APIs" do
      expect(h).not_to eq g
      expect { h < g }.to raise_error ArgumentError
    end
  end
end
