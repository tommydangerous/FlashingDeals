class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :deal_id
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
    add_index :stars, [:deal_id, :user_id], :unique => true
    add_index :stars, :value
  end
end
