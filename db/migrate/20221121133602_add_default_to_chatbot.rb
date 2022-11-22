class AddDefaultToChatbot < ActiveRecord::Migration[6.1]
  def change
    change_column_default :chatbots, :locale_id, 'en_IN'
  end
end
