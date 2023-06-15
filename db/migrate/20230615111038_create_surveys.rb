class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.string :first_question
      t.string :second_question
      t.string :third_question
      t.string :fourth_question

      t.references :user, foreign_key: true, null: true

      t.timestamps
    end
  end
end
