class AddUniqueIndexToFriendships < ActiveRecord::Migration
  def up
  	add_index :friendships, [:user_id, :friend_id], :unique => true
  end
end
