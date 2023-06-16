class SurveyQuestion < ApplicationRecord
  belongs_to :survey, optional: :true
  belongs_to :question
end
