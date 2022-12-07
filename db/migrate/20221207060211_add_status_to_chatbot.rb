class AddStatusToChatbot < ActiveRecord::Migration[6.1]
  def change
    add_column :chatbots, :status, :string, default: 'not_built', null: false
    add_index :chatbots, :status
  end
end
