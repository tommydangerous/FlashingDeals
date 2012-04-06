class DropMsgrelationships < ActiveRecord::Migration
  def up
  	drop_table :msgrelationships
  	add_index :messages, [:user_id, :recipient_id]
  end

  def down
  end
end
