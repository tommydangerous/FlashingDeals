class Bond < ActiveRecord::Base
	belongs_to :deal
	belongs_to :location
end
