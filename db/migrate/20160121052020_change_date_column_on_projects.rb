class ChangeDateColumnOnProjects < ActiveRecord::Migration
  def change
    change_column :projects, :startdate, :date
    change_column :projects, :enddate, :date
  end
end
