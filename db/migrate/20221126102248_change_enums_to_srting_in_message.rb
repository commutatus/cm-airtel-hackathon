class ChangeEnumsToSrtingInMessage < ActiveRecord::Migration[6.1]
  def change
    change_column :messages, :status, :string, comment: 'Delivery statue of the message.'
    change_column :messages, :sentiment, :string, comment: 'Analysed sentiment for the inbound message.'
    change_column :messages, :message_type, :string, comment: 'Inbound or outbound message.'
    add_index :messages, :status
    add_index :messages, :sentiment
    add_index :messages, :message_type
  end
end
