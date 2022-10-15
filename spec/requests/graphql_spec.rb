# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /graphql' do
  let(:query) do
    <<~GQL
      {
        __schema {
          queryType {
            name
          }
        }
      }
    GQL
  end

  describe 'queries' do
    context 'with valid query' do
      it 'returns data' do
        response_body = request_graphql(query:)

        aggregate_failures do
          expect(response_body).not_to have_key('errors')
          expect(response_body).to have_key('data')
        end
      end
    end

    context 'with invalid query' do
      let(:query) { 'query { id }' }

      it 'returns an error' do
        expected_error = "Field 'id' doesn't exist on type 'Query'"

        response_body = request_graphql(query:)

        expect(response_body['errors'][0]['message']).to eq(expected_error)
      end
    end
  end

  describe 'variables' do
    subject(:gql_response) { request_graphql(query:, variables:) }

    context 'when blank' do
      let(:variables) { '' }

      it { is_expected.to have_key('data') }
    end

    context 'when json' do
      let(:variables) { { id: 100 }.to_json }

      it { is_expected.to have_key('data') }
    end

    context 'when hash' do
      let(:variables) { { id: 100 } }

      it { is_expected.to have_key('data') }
    end

    context 'when integer' do
      let(:variables) { 123 }

      it { is_expected.to have_key('data') }
    end

    context 'when nil' do
      let(:variables) { nil }

      it { is_expected.to have_key('data') }
    end

    context 'when array' do
      let(:variables) { [] }

      it do
        expect do
          gql_response
        end.to raise_error(ArgumentError, 'Unexpected parameter: [""]')
      end
    end

    context 'when malformed json' do
      let(:variables) { :test }

      it do
        expect do
          gql_response
        end.to raise_error(JSON::ParserError, "859: unexpected token at 'test'")
      end
    end
  end

  describe 'schema errors' do
    subject(:gql_request) { post '/graphql' }

    let(:mock_error) { stub_const('MockError', StandardError) }

    before do
      allow(RailsGraphqlApiTemplateSchema).to receive(:execute).and_raise(mock_error)
    end

    context 'when not development environment' do
      it { expect { gql_request }.to raise_error(mock_error) }
    end

    context 'when development environment' do
      let(:env) { double }

      before do
        allow(env).to receive(:development?).and_return(true)
        allow(Rails).to receive(:env).and_return(env)
      end

      it { expect { gql_request }.not_to raise_error }
    end
  end

  def request_graphql(params)
    post '/graphql', params: params

    JSON.parse(response.body)
  end
end
