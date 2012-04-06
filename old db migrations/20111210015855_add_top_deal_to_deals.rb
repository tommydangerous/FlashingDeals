class AddTopDealToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :top_deal, :boolean, :default => false
  end
end
