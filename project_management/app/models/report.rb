class Report < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_reports
  has_and_belongs_to_many :projects
  serialize :report_data, JSON

  def is_available_to_clients?
    ((available_to_clients == true) ? true : false)
  end

  def get_tickets
    tickets = []
    @report.projects.each do |project|
      tickets << project.tickets
    end
    tickets
  end

  def get_filtered_tickets
    tickets = self.get_tickets

    if setting['ticket_status'] != 'All' && setting['ticket_type'] != 'All'
      tickets.where(:status => setting['ticket_status'])
    elsif setting['ticket_status'] != 'All'
      tickets.where(:status => setting['ticket_status'])
    elsif setting['ticket_type'] != 'All'
      tickets.where(:status => setting['ticket_type'])
    else
      tickets
    end
  end

  def get_comments_count
    count = 0
    self.get_tickets.each do |t|
      count += t.comments.count
    end
    count
  end
end
