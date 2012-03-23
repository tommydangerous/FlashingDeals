class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :user_id
      t.integer :referred_id

      t.timestamps
    end
    add_index :referrals, [:user_id, :referred_id], :unique => true
  end
end
