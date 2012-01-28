class ChangeViewCountAndClickCountDefaultOnDeals < ActiveRecord::Migration
  def change
    change_column :deals, :view_count, :integer, :default => 0
    change_column :deals, :click_count, :integer, :default => 0
    
    add_index :deals, :view_count
    add_index :deals, :click_count
  end
end
