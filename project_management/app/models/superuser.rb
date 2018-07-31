class Superuser < User
  def self.model_name
    User.model_name
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

  def can_add_clients
    true
  end

  def can_change_manager
    true
  end

  def can_assign_employees(id)
    true
  end

  def can_see_project_details
    true
  end

end
