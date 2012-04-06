class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :deal_id
      t.integer :category_id

      t.timestamps
    end
  end
end
