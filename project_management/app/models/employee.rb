class Employee < User
  has_and_belongs_to_many :roles, join_table: :employee_roles
  def self.model_name
    User.model_name
  end
end
