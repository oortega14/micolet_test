# frozen_string_literal: true

# Represents survey questions.
class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
end
