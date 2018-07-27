class ProjectsController < ApplicationController
  before_action :get_project, only: [:show, :edit, :update, :destroy, :dashboard, :add_client, :remove_client, :remove_employee]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end
	
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project
    else
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def dashboard
  end

  def add_client
    @client = Client.find(params[:project][:client_id])
    @project.clients << @client
  end

  def add_project_manager
    @projectWorker = ProjectWorker.new
    @projectWorker.project_id = params[:id]
    @projectWorker.user_id = params[:project][:employee_ids]
    @projectWorker.role_id = 1
    @projectWorker.save
  end

  def add_tester
    @employees = Employee.find(params[:project][:employee_ids])
    @employees.each do |employee|
      @projectWorker = ProjectWorker.new
      @projectWorker.project_id = params[:id]
      @projectWorker.user_id = params[:project][:employee_ids]
      @projectWorker.role_id = 3
      @projectWorker.save
    end
    redirect_to dashboard_path(@project)
  end

  def add_employees
    params[:project][:employee_ids].zip(params[:project][:role_ids]).each do |e, r|
      @projectWorker = ProjectWorker.new
      @projectWorker.project_id = params[:id]
      @projectWorker.user_id = e
      @projectWorker.role_id = r
      @projectWorker.save
    end
    redirect_to dashboard_path(@project)
  end

  def add_dev
    @employees = Employee.find(params[:project][:employee_ids])
    @employees.each do |employee|
      @projectWorker = ProjectWorker.new
      @projectWorker.project_id = params[:id]
      @projectWorker.user_id = params[:project][:employee_ids]
      @projectWorker.role_id = 2
      @projectWorker.save
    end
    redirect_to dashboard_path(@project)
  end

  def remove_client
    @client = Client.find(params[:client_id])
    @project.client_ids = @project.client_ids - [@client.id]
    redirect_to dashboard_path(@project)
  end

  def remove_employee
    @employee = Employee.find(params[:employee_ids])
    @project.employee_ids = @project.employee_ids - [@employee.id]
    redirect_to dashboard_path(@project)
  end

  private
    def project_params
      params.require(:project).permit(:title, :description, :client_id, :employee_ids => [])
    end

    def get_project
      @project = Project.find(params[:id])
    end

end
