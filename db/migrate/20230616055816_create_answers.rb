# frozen_string_literal: true

# Migration for creating answers
class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers, id: :uuid do |t|
      t.text :answer
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.references :question, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
