class AddDescriptionAndIntentIdToIntent < ActiveRecord::Migration[6.1]
  def change
    add_column :intents, :description, :string
    add_column :intents, :intent_id, :string, comment: 'AWS Lex intentId value, fetched during the creation from AWS.'
    change_column :chatbots, :bot_id, :string, comment: 'AWS Lex botId value, fetched during the creation from AWS.'
  end
end
