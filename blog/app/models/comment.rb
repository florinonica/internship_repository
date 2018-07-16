class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  validates_format_of :body, without: /<script/, message: "You are not allowed to post JS"
end
