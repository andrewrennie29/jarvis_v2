class Todo < ActiveRecord::Base
	belongs_to :project
	belongs_to :category
	has_one :status
	has_one :recur
	has_many :comments
	after_save :createstatus

	private
	def createstatus
		if self.status.nil?
			Status.create(:todo_id => id)
		end
	end
end
