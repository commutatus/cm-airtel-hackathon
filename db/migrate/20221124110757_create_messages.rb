class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :from
      t.string :to
      t.string :message_id
      t.string :session_id
      t.references :chatbot
      t.string :intent_name
      t.references :intent
      t.integer :status
      t.integer :sentiment
      t.string :sentiment_score
      t.integer :message_type
      t.timestamps
    end
  end
end
