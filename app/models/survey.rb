# frozen_string_literal: true

# Represents surveys.
class Survey < ApplicationRecord
  has_many :questions
end
