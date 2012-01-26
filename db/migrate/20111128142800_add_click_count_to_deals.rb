class AddClickCountToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :click_count, :integer
  end
end
