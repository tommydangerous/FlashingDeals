class AddColumnToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :info4, :string
    add_column :newsletters, :info5, :string
    add_column :newsletters, :info6, :string
    add_column :newsletters, :deal5, :integer
    add_column :newsletters, :deal6, :integer
    add_column :newsletters, :deal7, :integer
    add_column :newsletters, :deal8, :integer
  end
end
