class CreateRecurs < ActiveRecord::Migration
  def change
    create_table :recurs do |t|
      t.boolean :recurs, default: false
      t.string :frequency
      t.string :daypattern
      t.date :latestdate
      t.date :nextdate
      t.date :enddate
      t.references :todo, index: true

      t.timestamps
    end
  end
end
