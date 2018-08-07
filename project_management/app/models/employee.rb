class Employee < User
  has_and_belongs_to_many :roles, join_table: :employee_roles
  accepts_nested_attributes_for :roles

  def self.model_name
    User.model_name
  end

  def can_see_employees?
  	true
  end

  def is_manager?(id)
    self.project_workers.find_by(project_id: id).role_id == 1
  end

  def is_dev?(id)
    self.project_workers.find_by(project_id: id).role_id == 2
  end

  def is_tester?(id)
    self.project_workers.find_by(project_id: id).role_id == 3
  end

  def can_assign_employees?(id)
    (is_manager(id) ? true : false)
  end

  def can_see_project_details?
    true
  end

  def can_alter_ticket?(ticket)
    if (self.id == ticket.owner_id) || (self.tasks.include?(ticket) && (ticket.status =="To do" || ticket.status =="In progress")) || 
      (self.is_tester?(ticket.project_id) && ticket.status =="Dev complete") || self.is_manager?(ticket.project_id)
      return true
    end
    false
  end

  def can_delete_ticket?(ticket)
    ((id == ticket.owner_id) ? true : false)
  end

  def can_add_subtask_or_bug?(ticket)
    if self.is_tester?(ticket.project_id) || self.is_manager?(ticket.project_id) || self.id == ticket.dev_id
      return true
    end
    return false
  end

end
