class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	
	has_many :connections, :dependent => :destroy
	has_many :deals, :through => :connections
	
	default_scope :order => 'categories.name ASC'
end
