class Connection < ActiveRecord::Base
	belongs_to :deal
	belongs_to :category
end
