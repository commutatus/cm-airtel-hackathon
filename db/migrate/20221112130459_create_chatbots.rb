class CreateChatbots < ActiveRecord::Migration[6.1]
  def change
    create_table :chatbots do |t|
      t.string :name
      t.text :description
      t.string :bot_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
