class Followup < ActiveRecord::Base
	belongs_to :comment

	def self.complete(id)
		
	end

end
