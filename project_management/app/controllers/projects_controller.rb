class ProjectsController < ApplicationController
  before_action :get_project, only: [:show, :edit, :update, :destroy, :dashboard, :add_client, :add_employees, :add_dev, :remove_client, :remove_employee]

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

  def add_employees
    params[:project][:employee_ids].each do |e|
      @projectWorker = ProjectWorker.new
      @projectWorker.project_id = params[:id]
      @projectWorker.user_id = e
      @projectWorker.role_id = params[:project][:role_id]
      @projectWorker.save
    end
    redirect_to dashboard_path(@project)
  end

  def remove_client
    @project.client_ids = @project.client_ids - params[:client_id]
    redirect_to dashboard_path(@project)
  end

  def remove_employee
    @project.employee_ids = @project.employee_ids - params[:employee_ids]
    redirect_to dashboard_path(@project)
  end

  private
    def project_params
      params.require(:project).permit(:title, :description, :client_id, :employee,  :role_id, :employee_ids => [])
    end

    def get_project
      @project = Project.find(params[:id])
    end

end
