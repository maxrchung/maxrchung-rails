class AddBlogidToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :blog, index: true
  end
end
