class AddViewCountToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :view_count, :integer
  end
end
