class Report < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_reports
  has_and_belongs_to_many :projects
  serialize :report_data, JSON

  def is_available_to_clients?
    ((available_to_clients == true) ? true : false)
  end

  def get_tickets
    tickets = []
    projects.each do |project|
      tickets << project.tickets
    end
    tickets
  end

  def get_filtered_by_status(status)
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.status == status && t.created_at >= report_data['start_date'] && t.created_at <= report_data['end_date']
      end
    end
    tickets
  end

  def get_filtered_by_created(date)
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.created_at < date
      end
    end
    tickets
  end

  def get_filtered_by_ended(date)
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.end_at.presence && t.end_at < date
      end
    end
    tickets
  end

  def get_tasks
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t unless t.task_id.presence && t.created_at >= report_data['start_date'] && t.created_at <= report_data['end_date']
      end
    end
    tickets
  end

  def get_subtasks
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.task_id.presence  && !(t.is_a? Bug) && t.created_at >= report_data['start_date'] && t.created_at <= report_data['end_date']
      end
    end
    tickets
  end

  def get_bugs
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.task_id.presence && (t.is_a? Bug) && t.created_at >= report_data['start_date'] && t.created_at <= report_data['end_date']
      end
    end
    tickets
  end

  def get_comments_count
    count = 0
    self.get_tickets.each do |t|
      count += t.comments.count
    end
    count
  end

  def get_average_ticket_solving_time
    count = 0
    sum = 0.0
    get_filtered_by_status("Done").each do |ticket|
      count += 1
      sum += (ticket.end_at - ticket.created_at)
    end
    sum/count/3600
  end
end
