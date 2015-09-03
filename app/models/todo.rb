class Todo < ActiveRecord::Base
	belongs_to :project
	belongs_to :category
	has_one :status
	has_one :recur
	has_many :comments
	after_save :createstatus

	def self.statusobjects(options = {} )

		defaults = { :user_id => nil,
    						:project_id => nil,
    						:option_3 => nil,
    						:option_4 => nil}
  	options = defaults.merge!(options)

		unless options[:project_id].nil?
			@project = Project.find_by_slug(options[:project_id])
    	@todos = @project.todos.joins(:status).order('statuses.complete asc, todos.assigneddate asc, todos.duedate asc, todos.name asc')
    end

    if options[:project_id].nil?
    	@todos = User.find_by_id(options[:user_id]).todos.joins(:status).all
    end 

    statusobjects = {:pointsremaining => @todos.where('statuses.complete = false').sum(:points),
    									:completedtodos => @todos.where('statuses.complete = true').count,
    									:completedpoints => @todos.where('statuses.complete = true').sum(:points),
    									:inprogresstodos => @todos.where('statuses.complete = false and statuses.notstarted = false').count,
    									:inprogresspoints => @todos.where('statuses.complete = false and statuses.notstarted = false').sum(:points),
    									:overduetodos => @todos.where('statuses.complete = false and todos.duedate < curdate()').count,
    									:overduepoints => @todos.where('statuses.complete = false and todos.duedate < curdate()').sum(:points),
    									:totaltodos => @todos.count,
    									:totalpoints => @todos.sum(:points)}
	
    return statusobjects

	end

	private
	def createstatus
		if self.status.nil?
			Status.create(:todo_id => id)
		end
	end
end
