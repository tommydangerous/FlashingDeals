class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notice_id
      t.integer :deal_id
      t.integer :comment_id
      t.integer :subcomment_id

      t.timestamps
    end
    add_index :notifications, [:user_id, :notice_id, :deal_id, :comment_id, :subcomment_id], :unique => true, :name => :notifications_index
  end
end
