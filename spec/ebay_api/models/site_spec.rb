require "spec_helper"

RSpec.describe EbayApi::Site do
  subject(:version) { described_class[id] }

  context "by known id" do
    let(:id) { "16" }

    its(:id)         { is_expected.to eq 16            }
    its(:country)    { is_expected.to eq "AT"          }
    its(:code)       { is_expected.to eq "EBAY-AT"     }
    its(:languages)  { is_expected.to eq %w(de-AT)     }
    its(:host)       { is_expected.to eq "www.ebay.at" }
    its(:currencies) { is_expected.to eq %w(EUR)       }
  end

  context "by unknown id" do
    let(:id) { 500 }

    it "raises ArgumentError" do
      expect { subject }.to raise_error ArgumentError
    end
  end
end
