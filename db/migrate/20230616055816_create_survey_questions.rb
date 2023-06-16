class CreateSurveyQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :survey_questions, id: :uuid do |t|
      t.text :answer
      t.references :survey, null: true, foreign_key: true, type: :uuid
      t.references :question, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
