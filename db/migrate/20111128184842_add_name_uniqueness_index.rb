class AddNameUniquenessIndex < ActiveRecord::Migration
  def up
  	add_index :deals, :name, :unique => true
  	add_index :deals, :metric
  end

  def down
  end
end
