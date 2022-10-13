source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.1.2"

gem "bootsnap", require: false
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "bullet"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
end

group :test do
  gem 'database_cleaner-active_record'
  gem "faker"
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
