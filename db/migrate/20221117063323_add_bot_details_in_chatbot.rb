class AddBotDetailsInChatbot < ActiveRecord::Migration[6.1]
  def change
    add_column :chatbots, :phone_number, :string
    add_column :chatbots, :bot_alias_id, :string
    add_column :chatbots, :locale_id, :string
  end
end
