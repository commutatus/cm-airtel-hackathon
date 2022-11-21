class CreateChatbotSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :chatbot_sessions do |t|
      t.string :from
      t.string :to
      t.references :chatbot
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :last_message_at
      t.string :session_id
      t.timestamps
    end
  end
end
