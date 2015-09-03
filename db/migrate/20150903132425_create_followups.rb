class CreateFollowups < ActiveRecord::Migration
  def change
    create_table :followups do |t|
    	t.boolean :complete, default: false
    	t.references :comment, index: true
      t.timestamps
    end
  end
end
