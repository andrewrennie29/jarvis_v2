class Status < ActiveRecord::Base
  belongs_to :todo
  
  def update_status(status_params)
  	self.delayed = true
  end

end
