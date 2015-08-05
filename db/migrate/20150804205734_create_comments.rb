class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :details
      t.references :todo, index: true

      t.timestamps
    end
  end
end
