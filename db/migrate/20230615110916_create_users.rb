class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.boolean :answer_survey
      t.boolean :email_verified

      t.timestamps
    end
  end
end
