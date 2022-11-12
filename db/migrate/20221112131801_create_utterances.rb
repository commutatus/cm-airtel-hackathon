class CreateUtterances < ActiveRecord::Migration[6.1]
  def change
    create_table :utterances do |t|
      t.text :content
      t.references :intent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
