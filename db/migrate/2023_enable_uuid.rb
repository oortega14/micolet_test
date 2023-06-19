# frozen_string_literal: true

# Migration for enabling UUID in this application
class EnableUuid < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'
  end
end
