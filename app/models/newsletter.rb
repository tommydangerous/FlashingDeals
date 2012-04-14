class Newsletter < ActiveRecord::Base
	attr_accessible :name, :info1, :info2, :info3, :info4, :info5, :info6, :deal1, :deal2, :deal3, :deal4, :deal5, :deal6, :deal7, :deal8, :emailed
	
	validates_presence_of :name, :unique => true
end