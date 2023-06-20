# frozen_string_literal: true

# create_table 'preferences', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
#   t.string 'name'
#   t.string 'internal_key'
#   t.uuid 'user_id'
#   t.datetime 'created_at', null: false
#   t.datetime 'updated_at', null: false
#   t.index ['user_id'], name: 'index_preferences_on_user_id'
# end

# Represents user preferences.
class Preference < ApplicationRecord
  belongs_to :user
end
