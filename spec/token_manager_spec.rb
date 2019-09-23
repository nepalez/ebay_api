# frozen_string_literal: true

require "spec_helper"
require "ebay_api/token_manager"

describe EbayAPI::TokenManager do
  let(:refresh_response) do
    { status: 200, body: '{"access_token":"new_token","expires_in":7200}' }
  end
  let!(:api) do
    stub_request(:post, "https://api.sandbox.ebay.com/identity/v1/oauth2/token")
        .with(
            body: { grant_type: "refresh_token", refresh_token: "refreshing" },
            basic_auth: %w[1 2]
        )
        .to_return(refresh_response)
  end

  let(:access_token)   { "old_token" }
  let(:refresh_token)  { "refreshing" }
  let(:access_expire)  { Time.now + 120 }
  let(:refresh_expire) { Time.now + 1 }
  let(:callback) { proc {} }

  subject do
    described_class.new(
        access_token:  access_token,  access_token_expires_at:  access_expire,
        refresh_token: refresh_token, refresh_token_expires_at: refresh_expire,
        appid: "1", certid: "2", sandbox: true,
        on_refresh: callback
    )
  end

  before do
    Timecop.freeze
    allow(callback).to receive(:call).with("new_token", Time.now + 7200)
  end

  after { Timecop.return }

  describe "#access_token" do
    context "with valid access_token" do
      it "returns access_token" do
        expect(subject.access_token).to eq("old_token")
        expect(api).not_to have_been_requested
      end
    end

    context "with expired access_token" do
      let(:access_expire) { Time.now }

      it "gets and returns a new access token" do
        expect(subject.access_token).to eq("new_token")
        expect(api).to have_been_requested
      end
    end

    context "with access_token which is about to expire" do
      let(:access_expire) { Time.now + 15 }

      it "gets and returns a new access token" do
        expect(subject.access_token).to eq("new_token")
        expect(api).to have_been_requested
      end
    end

    context "without tokens" do
      let(:access_token)   { nil }
      let(:refresh_token)  { nil }
      let(:access_expire)  { nil }
      let(:refresh_expire) { nil }

      it "just returns nil" do
        expect(subject.access_token).to eq(access_token)
        expect(api).not_to have_been_requested
      end
    end
  end

  describe "#refresh!" do
    context "with valid refresh token" do
      it "requests new token from API" do
        subject.refresh!
        expect(api).to have_been_requested
        expect(subject.access_token).to eq("new_token")
        expect(subject.access_token_expires_at).to eq(Time.now + 7200)
      end

      it "calls callback" do
        subject.refresh!
        expect(callback).to have_received(:call)
      end
    end

    context "with expired refresh token" do
      let(:refresh_expire)  { Time.now }

      it "raises exception" do
        expect { subject.refresh! }.to \
          raise_error(EbayAPI::TokenManager::RefreshTokenExpired)
      end
    end

    context "with revoked refresh token" do
      let(:refresh_response) do
        {
          status: 400,
          body: '{"error":"invalid_grant","error_description":"fiasco"}'
        }
      end

      it "raises exception" do
        expect { subject.refresh! }.to raise_error(
          EbayAPI::TokenManager::RefreshTokenInvalid, "invalid_grant - fiasco"
        )
      end
    end

    context "with client not authorized" do
      let(:refresh_response) do
        {
          status: 400,
          body: '{"error":"unauthorized_client","error_description":"fiasco"}'
        }
      end

      it "raises exception" do
        expect { subject.refresh! }.to raise_error(
          EbayAPI::TokenManager::RefreshTokenInvalid,
          "unauthorized_client - fiasco"
        )
      end
    end

    context "on eBay's internal server error" do
      let(:refresh_response) do
        {
          status: 500,
          body: '{"error":"server_error","error_description":"this is fiasco"}'
        }
      end

      it "raises exception" do
        expect { subject.refresh! }.to raise_error \
          EbayAPI::InternalServerError, /server_error - this is fiasco/
      end
    end

    context "when server returns nonparseable result" do
      let(:refresh_response) do
        { status: 502, body: "<HTML><H1>Gateway timeout</H1></HTML>" }
      end

      it "raises exception" do
        expect { subject.refresh! }.to raise_error \
          EbayAPI::Error, /isn't JSON: 502 .*Gateway timeout/
      end
    end
  end
end
