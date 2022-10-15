# frozen_string_literal: true

class ActiveRecordTestModel < ApplicationRecord
  def id
    SecureRandom.uuid
  end

  def self.load_schema!
    @columns_hash = {}
  end
end
