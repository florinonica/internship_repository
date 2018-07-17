class Project < ApplicationRecord
  has_many :tickets, foreign_key: :project_id, dependent: :destroy
  has_many :project_workers
  has_many :users, through: :project_workers
end
