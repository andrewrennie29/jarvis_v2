class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :name
      t.text :details
      t.date :duedate
      t.date :assigneddate
      t.integer :importance
      t.time :timerequired
      t.references :category, index: true
      t.references :project, index: true
      t.references :user, index: true
      t.references :status, index: true
      t.references :recur, index:true
      t.timestamps
    end
  end
end
