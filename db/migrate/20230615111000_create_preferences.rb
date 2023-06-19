class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences, id: :uuid do |t|
      t.string :name
      t.string :internal_key
      t.references :user, foreign_key: true, null: true, type: :uuid

      t.timestamps
    end
  end
end
