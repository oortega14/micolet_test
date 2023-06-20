# frozen_string_literal: true

# create_table 'answers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
#   t.text 'answer'
#   t.uuid 'user_id'
#   t.uuid 'question_id', null: false
#   t.datetime 'created_at', null: false
#   t.datetime 'updated_at', null: false
#   t.index ['question_id'], name: 'index_answers_on_question_id'
#   t.index ['user_id'], name: 'index_answers_on_user_id'
# end

# Represents user answers.
class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
end
