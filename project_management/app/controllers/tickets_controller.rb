class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def new
    @project = Project.find(params[:ticket_id])
    @ticket = Ticket.new
  end

  def create
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.new ticket_params
    @ticket.owner_id = current_user.id
    @ticket.save
    redirect_to dashboard_path(@project)
  end

  def edit
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
    @ticket.destroy
    redirect_to project_path(@project)
  end

  def add_dev
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
    @employee = Employee.find(params[:project][:employee_ids])
    @ticket.dev_id = params[:project][:dev_id]
    @projectWorker = ProjectWorker.new
    @projectWorker.project_id = @project
    @projectWorker.user_id = @employee
    @projectWorker.role_id = Role.find(2)
    @projectWorker.save
    @ticket.update(ticket_params)
  end

  private
    def ticket_params
      params.require(:ticket).permit(:title, :description, :attachment)
    end
end
