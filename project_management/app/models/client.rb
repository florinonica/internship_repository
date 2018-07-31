class Client < User
  has_and_belongs_to_many :projects, join_table: :clients_projects
  def self.model_name
    User.model_name
  end
  
end
