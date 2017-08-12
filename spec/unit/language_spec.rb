RSpec.describe EbayAPI::Language do
  describe "#call, #[]" do
    subject(:language) { described_class[key] }

    context "by known key" do
      let(:key) { :"zh-HK" }
      it { is_expected.to eq "zh-HK" }
    end

    context "by unknown key" do
      let(:key) { :"zh-RU" }

      it "raises ArgumentError" do
        expect { subject }.to raise_error(StandardError, /zh-RU/)
      end
    end
  end

  describe ".all" do
    subject { described_class.all }

    it "returns supported languages" do
      expect(subject).to match_array %w[
        de-AT de-CH de-DE en-AU en-CA en-GB en-IE en-IN en-MY en-PH en-SG en-US
        es-ES fr-BE fr-CA fr-FR it-IT nl-BE nl-NL pl-PL ru-RU zh-CN zh-HK
      ]
    end
  end
end
