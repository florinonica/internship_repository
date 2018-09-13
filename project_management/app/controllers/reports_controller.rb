class ReportsController < ApplicationController
  before_action :get_report, only: [:show, :destroy]

  def index
    @reports = Report.all
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
      redirect_to reports_path
    else
      render 'new'
    end
  end

  def destroy
    @report.destroy
  end

  private
    def report_params
      params.require(:report).permit(:start_date, :end_date, :include_comments_data, :ticket_type, :ticket_status, :chart_type, :project_ids => [], :employee_ids => [])
    end

    def get_report
      @report = Report.find(params[:id])
    end

end
