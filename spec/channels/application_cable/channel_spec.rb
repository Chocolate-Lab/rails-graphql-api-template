# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Channel do
  it 'can subscribe' do
    subscribe
    expect(subscription).to be_confirmed
  end
end
