class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions, id: :uuid do |t|
      t.text :question
      t.integer :position
      t.references :survey, foreign_key: true, null: true, type: :uuid

      t.timestamps
    end
  end
end
