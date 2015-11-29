class Link < ActiveRecord::Base
	validates :title, presence: true
	validates :url, presence: true
	has_many :comments
	serialize :tags, Array
	belongs_to :user
end
