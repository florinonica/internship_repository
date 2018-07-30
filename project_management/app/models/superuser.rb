class Superuser < User
  def self.model_name
    User.model_name
  end

  def can_see_projects
  	true
  end

  def can_create_project
  	true
  end

  def can_edit_project
  	true
  end

  def can_delete_project
  	true
  end

  def can_see_dashboard
  	true
  end

  def can_see_users
  	true
  end

  def can_create_user
  	true
  end

  def can_edit_user
  	true
  end

  def can_delete_user
  	true
  end

end
