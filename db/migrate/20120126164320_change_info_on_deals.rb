class ChangeInfoOnDeals < ActiveRecord::Migration
  def change
  	change_column :deals, :info, :text
  	change_column :messages, :content, :text
  	change_column :subcomments, :content, :text
  	change_column :comments, :content, :text
  end
end
