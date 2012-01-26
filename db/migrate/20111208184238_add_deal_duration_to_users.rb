class AddDealDurationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deal_duration, :integer, :default => 1
  end
end
