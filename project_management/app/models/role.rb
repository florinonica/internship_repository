class Role < ApplicationRecord
  has_and_belongs_to_many :user
  has_many :project_workers
end
