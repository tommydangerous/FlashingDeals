class CreateMessageRelationships < ActiveRecord::Migration
  def change
    create_table :message_relationships do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.integer :message_id

      t.timestamps
    end
    add_index :message_relationships, [:user_id, :recipient_id, :message_id], :unique => true, :name => 'message_relationships_index'
  end
end
