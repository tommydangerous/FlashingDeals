class Location < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	
	has_many :bonds
	has_many :deals, :through => :bonds
	
	default_scope :order => 'locations.name ASC'
end
