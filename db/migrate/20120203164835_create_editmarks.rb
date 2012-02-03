class CreateEditmarks < ActiveRecord::Migration
  def change
    create_table :editmarks do |t|
      t.integer :user_id
      t.integer :deal_id

      t.timestamps
    end
    add_index :editmarks, [:user_id, :deal_id], :unique => true
  end
end
