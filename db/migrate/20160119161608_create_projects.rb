class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :content
      t.string :description
      t.string :extension
      t.datetime :startdate
      t.datetime :enddate

      t.timestamps null: false
    end
  end
end
