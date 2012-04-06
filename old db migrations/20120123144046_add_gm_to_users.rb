class AddGmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gm, :boolean, :default => false
  end
end
