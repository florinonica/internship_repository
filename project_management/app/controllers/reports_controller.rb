class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def new
  end

  def create
  end

end
