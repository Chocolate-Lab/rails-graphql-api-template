# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.1.2'

gem 'bootsnap', require: false
gem 'graphql'
gem 'graphql-batch'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 7.0.4'
gem 'strong_migrations'

group :development, :test do
  gem 'bullet'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'annotate'
  gem 'ruby-lsp'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
