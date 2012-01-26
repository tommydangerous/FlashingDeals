class CreateMsgrelationships < ActiveRecord::Migration
  def change
    create_table :msgrelationships do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.integer :message_id

      t.timestamps
    end
    add_index :msgrelationships, [:user_id, :recipient_id, :message_id], :unique => true, :name => 'msgrelationships_index'
  end
end
