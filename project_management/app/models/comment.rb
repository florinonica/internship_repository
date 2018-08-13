class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :attachments, :as => :container, dependent: :destroy
  validates :body, :presence => true, length: { maximum: 200 }
  accepts_nested_attributes_for :attachments
end
