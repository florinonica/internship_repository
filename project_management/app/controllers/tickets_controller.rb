class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def new
    @project = Project.find(params[:project_id])
    @ticket = Ticket.new
  end

  def create
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.new ticket_params
    @ticket.owner_id = current_user.id
    if !(params[:ticket][:dev_id].nil? || params[:ticket][:dev_id] = "")
      @employee = Employee.find(params[:ticket][:dev_id])
      @ticket.dev_id = @employee.id
    end
    @ticket.save
    redirect_to dashboard_path(@project)
  end

  def edit
    @project = Project.find(params[:id])
    @ticket = @project.tickets.find(params[:project_id])
  end

  def update
    @project = Project.find(params[:id])
    @ticket = @project.tickets.find(params[:project_id])
    if @ticket.update(ticket_params)
      redirect_to dashboard_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @ticket = @project.tickets.find(params[:project_id])
    @ticket.destroy
    redirect_to dashboard_path(@project)
  end

  def assign_dev
    @project = Project.find(params[:id])
    @ticket = @project.tickets.find(params[:project_id])
    @employee = Employee.find(params[:project][:dev_id])
    @ticket.dev_id = params[:project][:dev_id]
    @ticket.save
  end

  private
    def ticket_params
      params.require(:ticket).permit(:title, :description, :attachment, :project_id, :dev_id)
    end
end
