class RemoveSectionFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :section
    drop_table :about_posts
  end
end
