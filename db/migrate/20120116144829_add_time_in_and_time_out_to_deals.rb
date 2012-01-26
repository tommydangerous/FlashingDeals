class AddTimeInAndTimeOutToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :time_in, :datetime
    add_column :deals, :time_out, :datetime
  end
end
