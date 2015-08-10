class AddActivetoProjects < ActiveRecord::Migration
  def change
  add_column :projects, :isactive, :boolean, default: true
  end
end
