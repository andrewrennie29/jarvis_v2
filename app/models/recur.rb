class Recur < ActiveRecord::Base
  belongs_to :todo

  def self.createdaypattern(selected_days)
  	dayhash = { "0" => "off", 
                  "1" => "off", 
                  "2" => "off",
                  "3" => "off",
                  "4" => "off", 
                  "5" => "off", 
                  "6" => "off"}
      dayhash = dayhash.merge(selected_days)
      daypattern = ''
      dayhash.each do |key,value|
        if value == "on"
        	daypattern = daypattern + '1'
        else
        	daypattern = daypattern + '0'
        end
      end

      return daypattern

  end
end
