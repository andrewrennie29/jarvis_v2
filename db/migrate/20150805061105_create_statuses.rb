class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.boolean :notstarted
      t.boolean :inprogress
      t.boolean :forreview
      t.boolean :delayed
      t.boolean :complete
      t.references :todo, index: true

      t.timestamps
    end
  end
end
