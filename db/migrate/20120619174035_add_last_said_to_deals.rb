class AddLastSaidToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :last_said, :datetime
    
    add_index :deals, :last_said
  end
end
