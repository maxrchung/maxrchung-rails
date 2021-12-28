class AddFileToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :file, :string
    remove_column :attachments, :name
  end
end
