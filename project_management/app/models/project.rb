class Project < ApplicationRecord
  has_many :tickets, foreign_key: :project_id, dependent: :destroy
  has_many :project_workers
  has_many :employees, through: :project_workers, source: :user
  has_many :roles, through: :project_workers
  has_and_belongs_to_many :clients, join_table: :clients_projects

  def get_bugs
  	self.tickets.where(:type => "Bug")
  end

  def get_tasks_to_do
  	self.tickets.where(:status => "To do")
  end

  def get_tasks_in_progress
  	self.tickets.where(:status => "In progress")
  end

  def get_tasks_dev_complete
  	self.tickets.where(:status => "Dev complete")
  end

  def get_tasks_done
  	self.tickets.where(:status => "Done")
  end
end
