class Question < ApplicationRecord
  has_many :survey_questions
  has_many :surveys, through: :survey_questions
end