# frozen_string_literal: true

# Represents user preferences.
class Preference < ApplicationRecord
  belongs_to :user
end
