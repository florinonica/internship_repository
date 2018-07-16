class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  mount_uploader :attachment, AttachmentUploader
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 50 }
  validates_format_of :text, without: /<script/, message: "You are not allowed to post JS"
end
