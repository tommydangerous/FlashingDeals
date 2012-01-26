class AddWeightToComments < ActiveRecord::Migration
  def change
    add_column :comments, :weight, :integer
  end
end
