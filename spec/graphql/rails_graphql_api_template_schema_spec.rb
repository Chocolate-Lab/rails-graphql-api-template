# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RailsGraphqlApiTemplateSchema do
  # Credit James Newton for this approach
  # https://jamesnewton.com/ | https://twitter.com/jameswritescode
  # https://jamesnewton.com/blog/how-i-test-graphql-in-rails-with-rspec#testing-your-schema
  describe 'graphql schema' do
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

  describe '.resolve_type' do
    it 'needs to be implemented' do
      expect do
        described_class.resolve_type('a', 'b', 'c')
      end.to raise_error(GraphQL::RequiredImplementationMissingError)
    end
  end

  describe 'relay object identification methods' do
    # defined in spec/support/active_record_test_model.rb
    let(:test_model) { ActiveRecordTestModel.new }
    let(:gid_param) { test_model.to_gid_param }

    describe '.id_from_object' do
      before do
        allow(test_model).to receive(:to_gid_param).and_return(gid_param)
      end

      it 'returns the rails global id' do
        expect(described_class.id_from_object(test_model, 'b', 'c')).to eq(gid_param)
      end
    end

    describe '.object_from_id' do
      before { allow(GlobalID).to receive(:find).with(gid_param).and_return(test_model) }

      it 'finds the record' do
        expect(described_class.object_from_id(gid_param, 'b')).to eq(test_model)
      end
    end
  end
end
