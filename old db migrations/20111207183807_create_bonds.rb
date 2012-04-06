class CreateBonds < ActiveRecord::Migration
  def change
    create_table :bonds do |t|
      t.integer :deal_id
      t.integer :location_id

      t.timestamps
    end
    add_index :bonds, [:deal_id]
    add_index :bonds, [:location_id]
    add_index :bonds, [:deal_id, :location_id], :unique => true
  end
end
