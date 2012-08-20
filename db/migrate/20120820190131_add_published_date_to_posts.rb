class AddPublishedDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :published_date, :datetime
    add_index :posts, :published_date
  end
end
