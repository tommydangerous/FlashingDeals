class AddPartnerToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :partner, :string
    add_column :users, :partner, :string
    
    add_index :deals, :partner
    add_index :users, :partner
  end
end
