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

  def add_client
    @project = Project.find(params[:id])
    @client = Client.find(params[:project][:client_id])
    @project.clients << @client
  end

  def add_project_manager
    @project = Project.find(params[:id])
    @employee = Employee.find(params[:project][:employee_ids])
    @projectWorker = ProjectWorker.new
    @projectWorker.project_id = @project
    @projectWorker.user_id = @employee
    @projectWorker.role_id = Role.find(1)
    @projectWorker.save
  end

  def dashboard
    @project = Project.find(params[:id])
  end

  def add_tester
    @project = Project.find(params[:id])
    @employee = Employee.find(params[:project][:employee_ids])
    @projectWorker = ProjectWorker.new
    @projectWorker.project_id = @project
    @projectWorker.user_id = @employee
    @projectWorker.role_id = Role.find(3)
    @projectWorker.save
  end

  private
    def project_params
      params.require(:project).permit(:title, :description, :client_id)
    end

end
