class Employee < User
  has_and_belongs_to_many :roles, join_table: :employee_roles
  def self.model_name
    User.model_name
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

  def can_see_dashboard
  	true
  end

  def can_see_users
  	true
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

end
