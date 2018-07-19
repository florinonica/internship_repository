class Project < ApplicationRecord
  has_many :tickets, foreign_key: :project_id, dependent: :destroy
  has_many :project_workers
  has_many :employees, through: :project_workers
  has_and_belongs_to_many :clients
end
