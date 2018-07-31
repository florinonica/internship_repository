class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :owner, class_name: "Employee", optional: true
  belongs_to :dev, class_name: "Employee", optional: true
  belongs_to :task, class_name: "Ticket", optional: true
  has_many :comments, foreign_key: :ticket_id, dependent: :destroy
  has_many :subtasks, class_name: "Ticket", foreign_key: :task_id, dependent: :destroy

  def get_colour
  	case self.priority 
  	when "High"
  		return "#EA0B07"
  	when "Medium"
  		return "#F4E518"
  	when "Low"
  		return "#28ED42"
  	else
  		return "#fff"
  	end
  end
end
