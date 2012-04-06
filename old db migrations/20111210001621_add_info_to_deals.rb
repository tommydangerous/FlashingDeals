class AddInfoToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :info, :string
  end
end
