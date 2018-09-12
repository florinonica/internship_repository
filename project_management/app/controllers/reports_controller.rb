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
      params.require(:report).permit(:start_date, :end_date, :project_ids => [], :employee_ids => [])
    end

    def get_report
      @report = Report.find(params[:id])
    end

end
