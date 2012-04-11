class RemoveIndexFromDeals < ActiveRecord::Migration
  def up
  	remove_index :deals, :name
  	add_index :deals, :name
  end

  def down
  end
end
