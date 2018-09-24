class ReportsController < ApplicationController
  before_action :get_report, only: [:show, :destroy, :change_availability, :download]

  def index
    @reports = Report.paginate(:page => params[:page], per_page:5)
  end

  def show
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_data: report_params)
    params.require(:report).permit(:available_to_clients)
    @report.available_to_clients = params[:report][:available_to_clients]
    if @report.save
      params[:report][:project_ids].each do |pid|
        @report.projects << Project.find(pid)
      end
      params[:report][:employee_ids].each do |eid|
        @report.users << User.find(eid)
      end
      redirect_to @report
    else
      render 'new'
    end
  end

  def destroy
    @report.destroy
  end

  def change_availability
    params.require(:report).permit(:available_to_clients)
    @report.update(:available_to_clients => params[:report][:available_to_clients])
    redirect_to @report
  end

  def update_projects
    @projects = Project.all
  end

  def update_employees
    @employees = Employee.all
  end

  private
    def report_params
      params.require(:report).permit(:start_date, :end_date, :ticket_type, :ticket_status, :chart_type, :include_comments_data, :project_ids => [], :employee_ids => [])
    end

    def get_report
      @report = Report.find(params[:id])
    end

end
