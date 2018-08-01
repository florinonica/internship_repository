class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  #validates :email, :presence => true, :email => true
  has_many :tickets, foreign_key: :owner_id
  has_many :tasks, foreign_key: :dev_id
  has_many :bugs, foreign_key: :bug_id
  has_many :project_workers
  has_many :projects, through: :project_workers

  def full_name
    "#{first_name} #{last_name}"
  end

  def get_projects
    if self.type == "Superuser"
      Project.all
    else
      self.projects
    end
  end

  def can_see_projects
    true
  end

  def can_create_project
    false
  end

  def can_edit_project
    false
  end

  def can_delete_project
    false
  end

  def can_see_all_users
    false
  end

  def can_create_user
    false
  end

  def can_edit_user
    false
  end

  def can_delete_user
    false
  end

  def can_add_clients
    false
  end

  def can_change_manager
    false
  end

  def can_assign_employees(id)
    false
  end

  def can_see_project_details
    false
  end

  def can_see_employees
    false
  end

  def can_alter_ticket(ticket)
    false
  end

end
