class AddExclusiveCouponRebateToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :exclusive, :boolean
    add_column :deals, :coupon, :string
    add_column :deals, :rebate, :string
    
    add_index :deals, :exclusive
    add_index :deals, :coupon
    add_index :deals, :rebate
  end
end
