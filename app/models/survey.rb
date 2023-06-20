# frozen_string_literal: true

# create_table 'surveys', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
#   t.string 'name'
#   t.string 'language'
#   t.datetime 'created_at', null: false
#   t.datetime 'updated_at', null: false
# end

# Represents surveys.
class Survey < ApplicationRecord
  has_many :questions
end
