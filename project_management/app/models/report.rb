class Report < ApplicationRecord
  has_many :employees
  has_many :projects
  serialize :report_data, JSON
end
