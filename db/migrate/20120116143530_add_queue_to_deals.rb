class AddQueueToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :queue, :boolean, :default => false
    add_index :deals, :queue
  end
end
