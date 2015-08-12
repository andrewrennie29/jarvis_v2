class Status < ActiveRecord::Base
  belongs_to :todo
  
  def update_status(status_params)
  	self.update(:notstarted => status_params["notstarted"] == "false",
  				:inprogress => status_params["inprogress"] == "false",
  				:forreview => status_params["forreview"] == "false",
  				:delayed => status_params["delayed"] == "false",
  				:complete => status_params["complete"] == "false")
  end

end
