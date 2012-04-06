class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :name
      t.float :price
      t.float :value
      t.float :discount
      t.float :savings
      t.string :image
      t.string :link
      t.string :site
      t.float :rating
      t.float :up_rating
      t.float :down_rating
      t.float :metric
      t.string :tag
      t.datetime :posted

      t.timestamps
    end
  end
end
