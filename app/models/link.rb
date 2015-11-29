class Link < ActiveRecord::Base
	has_many :comments
	serialize :tags, Array
end
