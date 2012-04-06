class AddSubscribeToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :subscribe, :boolean, :default => true
  	add_index  :users, :subscribe
  end
end
