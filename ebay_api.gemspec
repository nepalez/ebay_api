Gem::Specification.new do |gem|
  gem.name     = "ebay_api"
  gem.version  = "0.0.3"
  gem.author   = "Andrew Kozin (nepalez)"
  gem.email    = "andrew.kozin@gmail.com"
  gem.homepage = "https://github.com/nepalez/sms_aero"
  gem.summary  = "HTTP(s) client to eBay Inventory API"
  gem.license  = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files       = gem.files.grep(/^spec/)
  gem.extra_rdoc_files = Dir["README.md", "LICENSE", "CHANGELOG.md"]

  gem.required_ruby_version = ">= 2.2"

  gem.add_runtime_dependency "evil-client", "~> 3.0", ">= 3.0.1"
  gem.add_runtime_dependency "dry-equalizer"

  gem.add_development_dependency "rake", ">= 10"
  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency "rspec-its", "~> 1.2"
  gem.add_development_dependency "rubocop", "~> 0.49"
  gem.add_development_dependency "timecop", "~> 0.9"
  gem.add_development_dependency "webmock", "~> 2.1"
  gem.add_development_dependency "httplog"
end
