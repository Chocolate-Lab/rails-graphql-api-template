# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::BaseMutation, type: :graphql do
  it 'can be' do
    expect(
      described_class.new(object: {}, context: {}, field: {})
    ).to be_instance_of(described_class)
  end
end
