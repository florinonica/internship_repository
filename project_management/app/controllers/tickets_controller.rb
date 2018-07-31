class TicketsController < ApplicationController
  before_action :get_project, only: [:index, :new, :create]
  before_action :get_ticket, only: [:show, :edit, :update, :destroy, :assign_dev]

  def index
    @tickets = @project.tickets
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def create
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
  end

  def update
    if @ticket.update(:status => params[:status])
      redirect_to dashboard_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @ticket.destroy
    redirect_to dashboard_path(@project)
  end

  private
    def ticket_params
      params.require(:ticket).permit(:title, :description, :attachment, :project_id, :dev_id, :priority, :status, :task_id)
    end

    def get_project
      @project = Project.find(params[:project_id])
    end

    def get_ticket
      @ticket = Ticket.find(params[:id])
    end
end
