class Report < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_reports
  has_and_belongs_to_many :projects
  serialize :report_data, JSON

  def is_available_to_clients?
    ((available_to_clients == true) ? true : false)
  end
end
