class AddProjectToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :project, index: true
  end
end
