class Movie < ActiveRecord::Base
	belongs_to :user

	validates :title, presence: true, uniqueness: true
	validates :description, presence: true
	
	def self.search(search)
		self.where( "title LIKE ?", "%#{search}%" ).first
	end
end
