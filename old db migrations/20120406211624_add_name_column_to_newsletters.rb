class AddNameColumnToNewsletters < ActiveRecord::Migration
  def change
  	add_column :newsletters, :name, :string
  	add_index :newsletters, :name
  end
end
