class Employee < User
  has_and_belongs_to_many :roles, join_table: :employee_roles
  accepts_nested_attributes_for :roles
  def self.model_name
    User.model_name
  end

  def can_see_employees
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

  def can_alter_ticket(ticket)
    if self.tickets.include?(ticket) || (self.tasks.include?(ticket) && (ticket.status =="To do" || ticket.status =="In progress")) || 
      (self.project_workers.find_by(project_id: ticket.project_id).role_id == 3 && ticket.status =="Dev complete")
      return true
    end
    return false
  end

end
