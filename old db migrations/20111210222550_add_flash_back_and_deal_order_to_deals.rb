class AddFlashBackAndDealOrderToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :flash_back, :boolean, :default => false
    add_column :deals, :deal_order, :integer
    add_index :deals, :top_deal
    add_index :deals, :flash_back
    add_index :deals, :deal_order
  end
end
