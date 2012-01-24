class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	
	has_many :connections
	has_many :deals, :through => :connections
	
	default_scope :order => 'categories.name ASC'
end
