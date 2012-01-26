class AddCityToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :city, :string
    add_index :deals, :city
  end
end
