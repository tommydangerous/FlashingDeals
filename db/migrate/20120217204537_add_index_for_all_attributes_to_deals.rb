class AddIndexForAllAttributesToDeals < ActiveRecord::Migration
  def change
  	add_index :deals, :price
  	add_index :deals, :value
  	add_index :deals, :discount
  	add_index :deals, :savings
  	add_index :deals, :link
  	add_index :deals, :site
  	add_index :deals, :tag
  	add_index :deals, :posted
  	add_index :deals, :created_at
  	add_index :deals, :updated_at
  	add_index :deals, :time_in
  	add_index :deals, :time_out
  end
end
