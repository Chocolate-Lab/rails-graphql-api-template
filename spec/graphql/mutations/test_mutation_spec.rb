# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::TestMutation, type: :graphql do
  it 'can be' do
    expect(described_class.new).to be_instance_of(described_class)
  end
end
