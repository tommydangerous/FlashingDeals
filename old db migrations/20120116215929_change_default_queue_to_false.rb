class ChangeDefaultQueueToFalse < ActiveRecord::Migration
  def up
  	change_column :deals, :queue, :boolean, :default => false
  end

  def down
  end
end
