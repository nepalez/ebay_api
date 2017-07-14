begin
  require "pry"
rescue LoadError
  nil
end

require "ebay_api"
require "webmock/rspec"
require "rspec/its"

require_relative "support/fixtures_helper"

RSpec.configure do |config|
  config.order = :random
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.around(:each) do |example|
    stub_request(:any, //)
    example.run
  end
end
