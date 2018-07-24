class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
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
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  def dashboard
    @project = Project.find(params[:id])
  end

  def add_client
    @project = Project.find(params[:id])
    @client = Client.find(params[:project][:client_id])
    @project.clients << @client
  end

  def add_project_manager
    @project = Project.find(params[:id])
    @employee = Employee.find(params[:project][:employee_ids])
    @projectWorker = ProjectWorker.new
    @projectWorker.project_id = @project.id
    @projectWorker.user_id = @employee.id
    @projectWorker.role_id = Role.find(1).id
    @projectWorker.save
  end

  def add_tester
    @project = Project.find(params[:id])
    @employees = Employee.find(params[:project][:employee_ids])
    @employees.each do |employee|
      @projectWorker = ProjectWorker.new
      @projectWorker.project_id = @project.id
      @projectWorker.user_id = employee.id
      @projectWorker.role_id = Role.find(3).id
      @projectWorker.save
    end
    redirect_to dashboard_path(@project)
  end

  def add_dev
    @project = Project.find(params[:id])
    @employees = Employee.find(params[:project][:employee_ids])
    @employees.each do |employee|
      @projectWorker = ProjectWorker.new
      @projectWorker.project_id = @project.id
      @projectWorker.user_id = employee.id
      @projectWorker.role_id = Role.find(2).id
      @projectWorker.save
    end
    redirect_to dashboard_path(@project)
  end

  private
    def project_params
      params.require(:project).permit(:title, :description, :client_id, :employee_ids => [])
    end

end
