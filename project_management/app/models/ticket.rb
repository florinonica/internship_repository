class Ticket < ApplicationRecord
  belogns_to :project
  belongs_to :owner, class_name: "User", optional: true
  belongs_to :tester, class_name: "User", optional: true
  belongs_to :dev, class_name: "User", optional: true
  belongs_to :task, class_name: "Ticket", optional: true
  has_many :subtasks, class_name: "Ticket", foreign_key: :task_id, dependent: :destroy
end
