class AddViewsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :views, :integer
    add_index :posts, :views
  end
end
