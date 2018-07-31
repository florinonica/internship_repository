class Employee < User
  has_and_belongs_to_many :roles, join_table: :employee_roles
  accepts_nested_attributes_for :roles
  def self.model_name
    User.model_name
  end

  def can_see_users
  	true
  end

  def can_assign_employees(id)
    if self.project_workers.find_by(project_id: id).role_id == 1
      return true
    end
    return false
  end

  def can_see_project_details
    true
  end

end
