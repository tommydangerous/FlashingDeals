class ChangeLinkToTextOnDeals < ActiveRecord::Migration
  def change
    change_column :deals, :link, :text
    change_column :deals, :image, :text
  end
end
