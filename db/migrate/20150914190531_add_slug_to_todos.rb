class AddSlugToTodos < ActiveRecord::Migration
  def change
  	add_column :todos, :slug, :string
  end
end
