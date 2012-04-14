class AddEmailedToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :emailed, :boolean, :default => false
    add_index :newsletters, :emailed
  end
end
