class Project < ActiveRecord::Base
  validates :extension, presence: true
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments
  mount_uploader :thumbnail, FileUploader
end
