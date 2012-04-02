class AddExpiresToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :expires, :datetime
  end
end
