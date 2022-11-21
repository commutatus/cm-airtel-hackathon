class CreateChatResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_responses do |t|
      t.json :response
      t.references :chatbot_session
      t.timestamps
    end
  end
end
