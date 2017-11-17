begin
  require "pry"
rescue LoadError
  nil
end

require "ebay_api"
require "webmock/rspec"
require "rspec/its"
require "timecop"

require_relative "support/fixtures_helper"

RSpec.configure do |config|
  config.order = :random
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

I18n.available_locales = %i[en]
I18n.locale = :en
I18n.load_path += ["config/locales/en.yml"]
