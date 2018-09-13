class Report < ApplicationRecord
  has_and_belongs_to_many :employees
  has_and_belongs_to_many :projects
  serialize :report_data, JSON
end
