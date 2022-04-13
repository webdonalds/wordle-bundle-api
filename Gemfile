source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Rails
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "graphql", "~> 2.0"

# Drivers
gem "pg", "~> 1.1"

# Web server
gem "puma", "~> 5.0"
gem "rack-cors", "~> 1.1"

# Authentications & Authorizations
gem "google-id-token", "~> 1.4"

# Ruby extensions
gem "figaro"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "faker"
end

group :test do
  gem "rspec"
  gem "rspec-mocks"
  gem "rspec-rails"
  gem "timecop"
end
