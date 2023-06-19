# frozen_string_literal: true

# Represents user answers.
class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
end
