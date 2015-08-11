class UpdateStatusDefaults < ActiveRecord::Migration
  def change
  	change_column_default :statuses, :notstarted, true
  	change_column_default :statuses, :inprogress, false
  	change_column_default :statuses, :forreview, false
  	change_column_default :statuses, :delayed, false
  	change_column_default :statuses, :complete, false
  end
end
