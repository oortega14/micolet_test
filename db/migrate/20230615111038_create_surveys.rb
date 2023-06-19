# frozen_string_literal: true

# Migration for creating surveys
class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys, id: :uuid do |t|
      t.string :name
      t.string :language

      t.timestamps
    end
  end
end
