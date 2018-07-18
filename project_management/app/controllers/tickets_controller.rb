class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def new
    @article = Project.find(params[:project_id])
    @ticket = Ticket.new
  end

  def create
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.new ticket_params
    @ticket.save
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
    @ticket.destroy
    redirect_to project_path(@project)
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

  private
    def ticket_params
      params.require(:ticket).permit(:title, :description, :attachment)
    end
end
