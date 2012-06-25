class AddFriendAlertAndReplyAlertToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friend_alert, :boolean, :default => true
    add_column :users, :reply_alert, :boolean, :default => true
    
    add_index :users, :friend_alert
    add_index :users, :reply_alert
  end
end
