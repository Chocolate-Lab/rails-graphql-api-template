# frozen_string_literal: true

require 'rails_helper'

# Credit James Newton for this approach
# https://jamesnewton.com/ | https://twitter.com/jameswritescode
# https://jamesnewton.com/blog/how-i-test-graphql-in-rails-with-rspec#testing-your-schema
RSpec.describe RailsGraphqlApiTemplateSchema do
  it 'matches the dumped schema `rails graphql:schema:dump`' do
    aggregate_failures do
      expect(described_class.to_definition.chop).to eq(schema_file('schema.graphql'))
      expect(described_class.to_json).to eq(schema_file('schema.json'))
    end
  end

  def schema_file(filename)
    Rails.root.join(filename).read.rstrip
  end
end
