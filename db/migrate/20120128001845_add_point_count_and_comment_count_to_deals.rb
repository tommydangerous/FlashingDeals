class AddPointCountAndCommentCountToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :point_count, :integer
    add_column :deals, :comment_count, :integer
    
    add_index :deals, :point_count
    add_index :deals, :comment_count
    
    Deal.find(:all).each do |deal|
    	deal.update_attribute(:point_count, deal.plusminus)
    	deal.update_attribute(:comment_count, (deal.comments.size + deal.subcomments.size))
    end
    
  end
end
