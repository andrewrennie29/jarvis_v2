class RemoveReferencesFromTodo < ActiveRecord::Migration
  def change
  	remove_column :todos, :status_id
  	remove_column :todos, :recur_id
  end
end
