class ChangeCommentCountAndPointCountOnDeals < ActiveRecord::Migration
  def change
    change_column :deals, :point_count, :integer, :default => 0
    change_column :deals, :comment_count, :integer, :default => 0
  end
end
