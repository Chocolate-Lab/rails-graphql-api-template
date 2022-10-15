# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Connection do
  it 'successfully connects' do
    expect { connect '/cable' }.not_to raise_error
  end
end
