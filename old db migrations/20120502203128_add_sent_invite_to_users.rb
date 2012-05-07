class AddSentInviteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sent_invite, :boolean, :default => false
    add_index :users, :sent_invite
  end
end
