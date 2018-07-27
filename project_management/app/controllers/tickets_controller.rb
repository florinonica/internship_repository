class TicketsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @tickets = @project.tickets
  end

  def new
    @project = Project.find(params[:project_id])
    @ticket = Ticket.new
  end

  def create
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.new ticket_params
    @ticket.owner_id = current_user.id
    if !(params[:ticket][:dev_id].nil? || params[:ticket][:dev_id] == "")
      @ticket.dev_id = params[:ticket][:dev_id]
    end
    if @ticket.save
      redirect_to dashboard_path(@project)
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to dashboard_path(Project.find(params[:project_id]))
    else
      render 'edit'
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to dashboard_path(@project)
  end

  def assign_dev
    @ticket = Ticket.find(params[:id])
    @ticket.dev_id = params[:project][:dev_id]
    @ticket.save
  end

  private
    def ticket_params
      params.require(:ticket).permit(:title, :description, :attachment, :project_id, :dev_id, :priority, :status, :task_id)
    end
end
