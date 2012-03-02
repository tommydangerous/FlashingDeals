class AddIndexToDealsOnDeadAndFlashmob < ActiveRecord::Migration
  def change
  	add_index :deals, :dead
  	add_index :deals, :flashmob
  end
end
