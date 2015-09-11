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
      daypattern = nil
      dayhash.each do |key,value|
        if value == "on"
          if daypattern.nil?
            daypattern = 1.to_s
          else
            daypattern = daypattern + 1.to_s
          end
        else
          if daypattern.nil?
            daypattern = 0.to_s
          else
            daypattern = daypattern + 0.to_s
          end
        end
      end
  end
end
