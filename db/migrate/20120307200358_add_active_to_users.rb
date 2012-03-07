class AddActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :datetime
    add_index :users, :active
  end
end
