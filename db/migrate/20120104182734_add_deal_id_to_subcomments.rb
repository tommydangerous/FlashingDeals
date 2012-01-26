class AddDealIdToSubcomments < ActiveRecord::Migration
  def change
    add_column :subcomments, :deal_id, :integer
    add_index :subcomments, :deal_id
  end
end
