class CreateWebhookEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :webhook_events do |t|
      t.string "source", null: false
      t.json "payload"
      t.string "event_type"
      t.string "webhook_event_id", null: false
      t.timestamps
    end
  end
end
