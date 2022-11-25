class AddIntentTypeToIntent < ActiveRecord::Migration[6.1]
  def change
    add_column :intents, :intent_type, :string, default: 'custom'
    add_index :intents, :intent_type
  end
end
