class AddBusinessIdInWebhookEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :webhook_events, :business_id, :string
    add_index :webhook_events, :business_id
    remove_column :webhook_events, :webhook_event_id
    add_column :webhook_events, :session_id, :string
  end
end
