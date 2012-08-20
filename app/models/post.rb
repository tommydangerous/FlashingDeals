class Post < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	
	attr_accessible :name, :content, :published, :views, :published_date
	
	validates :name, presence: true
	validates :content, presence: true
	
	default_scope order: 'posts.published_date DESC'
end
