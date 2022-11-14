class CreateIntents < ActiveRecord::Migration[6.1]
  def change
    create_table :intents do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :chatbot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
