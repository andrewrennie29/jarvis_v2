class ChangeTimerequiredtoPoints < ActiveRecord::Migration
  def change
  	change_column :todos, :timerequired, :integer
  	rename_column :todos, :timerequired, :points
  end
end
