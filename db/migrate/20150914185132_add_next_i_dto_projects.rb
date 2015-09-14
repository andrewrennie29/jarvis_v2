class AddNextIDtoProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :next_id, :integer, :default => 1
  end
end
