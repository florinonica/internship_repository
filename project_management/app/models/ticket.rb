class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :owner, class_name: "User"
  belongs_to :dev, class_name: "User", optional: true
  belongs_to :task, class_name: "Ticket", optional: true
  has_many :comments, foreign_key: :ticket_id, dependent: :destroy
  has_many :subtasks, class_name: "Task", foreign_key: :task_id, dependent: :destroy
  has_many :bugs, class_name: "Bug", foreign_key: :task_id, dependent: :destroy
  has_many :attachments, :as => :container, dependent: :destroy
  validates :title, :presence => true, length: { in: 3..50 }
  validates :description, :presence => true, length: { in: 10..200 }
  has_paper_trail

  before_create :set_type

  enum type: {'Task' => 0, 'Bug' => 1}

  def self.search(search)
    unless search=="All"
      where('type LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def get_owner
    User.find(owner_id)
  end

  def get_dev
    User.find(dev_id)
  end
  
  def get_colour
  	case priority 
  	when "High"
  		return "#F81115"
  	when "Medium"
  		return "#D8D51E"
  	when "Low"
  		return "#28ED42"
  	else
  		return "#fff"
  	end
  end

  def get_class_colour
    "#198DE8"
  end

  def get_glyph
    "glyphicon glyphicon-tasks"
  end

  private

    def set_type
      self.type = self.class.name
    end
  
end
