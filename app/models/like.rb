class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :link

	validate :has_user_liked

	def has_user_liked
		unless Like.where(:user_id => user.id, :link_id => link.id).count == 0
			errors.add(:user_id, "Link bereits geliked.")
		end
	end
end
 