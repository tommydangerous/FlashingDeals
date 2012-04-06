class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :deal_id

      t.timestamps
    end
    add_index :shares, [:user_id, :friend_id, :deal_id], :unique => true
  end
end
