class Client < User
  has_and_belongs_to_many :projects, join_table: :clients_projects
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
  	false
  end

  def can_see_users
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

end
