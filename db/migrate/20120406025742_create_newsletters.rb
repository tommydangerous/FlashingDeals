class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.text :info1
      t.text :info2
      t.text :info3
      t.integer :deal1
      t.integer :deal2
      t.integer :deal3
      t.integer :deal4

      t.timestamps
    end
  end
end
