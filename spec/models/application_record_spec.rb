# frozen_string_literal: true

require 'rails_helper'

class TestModel < ApplicationRecord
  def self.load_schema!
    @columns_hash = {}
  end
end

RSpec.describe ApplicationRecord do
  subject(:test_model) { TestModel.new }

  it { is_expected.to be_instance_of(TestModel) }
end
