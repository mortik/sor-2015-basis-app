class Link < ActiveRecord::Base
	has_many :comments
	has_many :likes
	def num_likes
		likes.count
	end
end
