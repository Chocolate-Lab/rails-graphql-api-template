# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationRecord do
  # defined in spec/support/active_record_test_model.rb
  subject(:test_model) { ActiveRecordTestModel.new }

  it { is_expected.to be_instance_of(ActiveRecordTestModel) }
end
