class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :content
      t.boolean :published, :default => false

      t.timestamps
    end
    add_index :posts, :name, :unique => true
    add_index :posts, :published
  end
end
