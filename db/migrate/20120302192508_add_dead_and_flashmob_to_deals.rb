class AddDeadAndFlashmobToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :dead, :boolean, :default => false
    add_column :deals, :flashmob, :boolean, :default => false
  end
end
