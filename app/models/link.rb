class Link < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
	has_many :comments
  belongs_to :user
end
