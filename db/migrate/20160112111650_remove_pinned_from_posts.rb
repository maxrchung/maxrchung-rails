class RemovePinnedFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :pinned
  end
end
