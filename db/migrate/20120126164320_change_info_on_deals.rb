class ChangeInfoOnDeals < ActiveRecord::Migration
  def up
  	change_column :deals, :info, :text
  	change_column :messages, :content, :text
  	change_column :subcomments, :content, :text
  	change_column :comments, :content, :text
  end

  def down
  end
end
