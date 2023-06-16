class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys, id: :uuid do |t|
      t.boolean :completed
      t.references :user, foreign_key: true, null: true, type: :uuid

      t.timestamps
    end
  end
end
