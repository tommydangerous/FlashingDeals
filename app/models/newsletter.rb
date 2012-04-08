class Newsletter < ActiveRecord::Base
	attr_accessible :name, :info1, :info2, :info3, :deal1, :deal2, :deal3, :deal4
	
	validates_presence_of :name, :unique => true
end