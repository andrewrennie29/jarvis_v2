class Todo < ActiveRecord::Base
	belongs_to :project
	belongs_to :category
	has_one :status
	has_one :recur
	has_many :comments
	after_save :createstatus

	private
	def createstatus
		Status.create(:todo_id => id)
	end
end
