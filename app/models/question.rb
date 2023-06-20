# frozen_string_literal: true

# create_table 'questions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
#   t.text 'question'
#   t.integer 'position'
#   t.uuid 'survey_id'
#   t.datetime 'created_at', null: false
#   t.datetime 'updated_at', null: false
#   t.index ['survey_id'], name: 'index_questions_on_survey_id'
# end

# Represents survey questions.
class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
end
