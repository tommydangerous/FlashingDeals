class AddUniqueIndexToConnections < ActiveRecord::Migration
  def change
  	add_index :connections, :deal_id
  	add_index :connections, :category_id
  	add_index :connections, [:deal_id, :category_id], :unique => true
  end
end
