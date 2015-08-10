class Todo < ActiveRecord::Base
	belongs_to :project
	belongs_to :category
	has_one :status
	has_one :recur
	has_many :comments

end
