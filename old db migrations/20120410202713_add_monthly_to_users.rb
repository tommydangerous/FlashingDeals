class AddMonthlyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :monthly, :boolean, :default => false
    add_index :users, :monthly
  end
end
