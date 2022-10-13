require 'simplecov'
require 'simplecov-console'

SimpleCov.start :rails do
  add_filter 'vendor'
end

SimpleCov.minimum_coverage 100

SimpleCov.formatter = if ENV["CI"] == "true"
  SimpleCov::Formatter::Console
else
  SimpleCov::Formatter::HTMLFormatter
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.order = :random
  config.profile_examples = 3

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
end
