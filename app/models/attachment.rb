class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :post
  belongs_to :project
  belongs_to :blog
end
