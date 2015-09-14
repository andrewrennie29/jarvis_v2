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

  def create_next_todo
  	
  	if self.enddate.nil?
  		comparison_date = '9999-12-31'.to_date
  	else
  		comparison_date = self.enddate
  	end

  	if comparison_date >= self.nextdate

  		@nexttodo = self.todo.dup
  		@nexttodo.save
  		@nexttodo.update(:duedate => self.nextdate, :assigneddate => nil)
  		self.update(:todo_id => @nexttodo.id, 
  								:latestdate => self.nextdate)
  		self.update(:nextdate => self.calculate_next_date)						

  	end

  end

  def calculate_next_date
		day_pattern = self.daypattern.slice(self.latestdate.wday,7 - self.latestdate.wday)

		if day_pattern.nil?
			day_pattern = self.daypattern
			dayoffset = 6
		else
			dayoffset = 0
		end

		dayoffset += day_pattern.index('1')

		if dayoffset == 0

			case self.frequency
			when 'Daily'		then calculatednextdate = self.latestdate.advance(:days => +1)
			when 'Weekly'		then calculatednextdate = self.latestdate.advance(:weeks => +1)
			when 'Monthly'	then calculatednextdate = self.latestdate.advance(:months => +1)
			end

		else
			calculatednextdate = self.latestdate.advance(:days => dayoffset)
		end

  end

end
