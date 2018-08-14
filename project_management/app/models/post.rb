class Post < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :attachments, :as => :container, dependent: :destroy
  validates :body, :presence => true, length: { maximum: 200 }
  accepts_nested_attributes_for :attachments
end
