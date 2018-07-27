class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
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
  end

  def can_create_project
  end

  def can_edit_project
  end

  def can_delete_project
  end

  def can_see_dashboard
  end

  def can_see_users
  end

  def can_create_user
  end

  def can_edit_user
  end

  def can_delete_user
  end

end
