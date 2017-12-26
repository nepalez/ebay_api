# frozen_string_literal: true

require "spec_helper"
require "ebay_api/paginated_collection"

RSpec.describe EbayAPI::PaginatedCollection do
  let!(:operation) do
    class EbayAPI
      operation :test_paginated_operation do
        http_method :get
        path "sell/marketing/v1/ad_campaign"

        option :limit,  optional: true
        option :offset, optional: true

        query { { limit: limit, offset: offset }.compact }

        middleware { PaginatedCollection::MiddlewareBuilder.call(max_limit: 2) }

        response(200) do |*response|
          EbayAPI::PaginatedCollection.new(self, response, "campaigns")
        end
      end
    end
  end

  let(:client)   { EbayAPI.new(settings) }
  let(:settings) { yaml_fixture_file(settings_file) }
  let(:settings_file) { "settings.valid.yml" }

  # Mimic real paginated API
  let!(:request) do
    uri_template = Addressable::Template.new(
      "https://api.ebay.com/sell/marketing/v1/ad_campaign{?limit,offset}"
    )
    stub_request(:get, uri_template).to_return do |request|
      uri = Addressable::URI.parse(request.uri)
      offset = uri.query_values&.fetch("offset", nil).to_i || 0
      limit  = uri.query_values&.fetch("limit", nil)&.to_i || 2
      total  = 5
      this_uri = uri.dup.tap do |u|
        new_params = { "offset" => offset, "limit" => limit }
        u.query_values = (uri.query_values || {}).merge(new_params)
      end
      next_uri = this_uri.dup.tap do |u|
        u.query_values = this_uri.query_values.merge("offset" => offset + limit)
      end
      on_this_page = offset + limit <= total ? limit : total - offset
      response = {
        href: this_uri,
        total: total,
        next: (next_uri if offset + limit < total),
        campaigns: Array.new(on_this_page) { |i| { id: offset + i } }
      }
      { body: response.to_json }
    end
  end

  let(:params) { {} }

  subject { client.test_paginated_operation(**params) }

  it "retrieves all pages" do
    expect(subject.to_a).to eq(Array.new(5) { |i| { "id" => i } })
    expect(request).to have_been_requested.times(3)
  end

  it "retrieves all pages lazily" do
    e = subject.lazy
    expect(e.next).to eq({ "id" => 0 })
    expect(e.next).to eq({ "id" => 1 })
    expect(request).to have_been_requested.once
    expect(e.next).to eq({ "id" => 2 })
    expect(e.next).to eq({ "id" => 3 })
    expect(request).to have_been_requested.twice
    expect(e.next).to eq({ "id" => 4 })
    expect { e.next }.to raise_exception(StopIteration)
    expect(request).to have_been_requested.times 3
  end

  context "with custom offset" do
    let(:params) { { offset: 3 } }

    it "retrieves pages only with this offset" do
      e = subject.lazy
      expect(e.next).to eq({ "id" => 3 })
      expect(e.next).to eq({ "id" => 4 })
      expect { e.next }.to raise_exception(StopIteration)
      expect(request).to have_been_requested.once
    end
  end

  context "with custom limit" do
    let(:params) { { limit: 3 } }

    it "retrieves pages only specified number of records" do
      e = subject.lazy
      expect(e.next).to eq({ "id" => 0 })
      expect(e.next).to eq({ "id" => 1 })
      expect(request).to have_been_requested.once
      expect(e.next).to eq({ "id" => 2 })
      expect { e.next }.to raise_exception(StopIteration)
      expect(request).to have_been_requested.twice
    end
  end
end
