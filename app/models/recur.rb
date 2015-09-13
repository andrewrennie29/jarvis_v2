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

  def self.createnext(todo_id)
  	@todo = Todo.find_by_id(todo_id)
  	@recur = @todo.recur

  	if @recur.enddate <= @recur.nextdate

  		@nexttodo = @todo.dup
  		@nexttodo.update(:duedate => @recur.nextdate, :assigneddate => nil)
  		@nexttodo.save

  		daypatternsplit = @recur.daypattern.slice(@recur.latestdate.wday,7 - @recur.latestdate.wday).split(//)
  		
  		if daypatternsplit.nil?
  			daypatternsplit = @recur.daypattern.split(//)
  			dayoffset = 6
  		else
  			dayoffset = 0
  		end

  		daypatternsplit.each do |d|
  			unless d.to_i == 1
  				dayoffset = dayoffset + 1
  			end
  		end

  		if dayoffset == 0

	  		case @recur.frequency
	  		when 'Daily'		then calculatednextdate = @recur.latestdate.advance(:days => +1)
	  		when 'Weekly'		then calculatednextdate = @recur.latestdate.advance(:weeks => +1)
	  		when 'Monthly'	then calculatednextdate = @recur.latestdate.advance(:months => +1)
	  		end

  		else
  			calculatednextdate = @recur.latestdate.advance(:days => dayoffset + 1)
  		end

  		unless Date.valid_date?(calculatednextdate)
  			calculatednextdate = calculatednextdate.advance(:days => +1)
  		end

  		@recur.update(:todo_id => @nexttodo.id, 
  									:latestdate => @recur.nextdate,
  									:nextdate => calculatednextdate)

  	else



  	end

  end

  def calculate_next_date
		daypatternsplit = self.daypattern.slice(self.latestdate.wday,7 - self.latestdate.wday).split(//)
		
		if daypatternsplit.nil?
			daypatternsplit = self.daypattern.split(//)
			dayoffset = 6
		else
			dayoffset = 0
		end
		
		daypatternsplit.each do |d|
			unless d.to_i == 1
				dayoffset = dayoffset + 1
			end
		end
		
		if dayoffset == 0

			case self.frequency
			when 'Daily'		then calculatednextdate = self.latestdate.advance(:days => +1)
			when 'Weekly'		then calculatednextdate = self.latestdate.advance(:weeks => +1)
			when 'Monthly'	then calculatednextdate = self.latestdate.advance(:months => +1)
			end

		else
			calculatednextdate = self.latestdate.advance(:days => dayoffset + 1)
		end
		
  end

end
