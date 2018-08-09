class TicketsController < ApplicationController
  before_action :get_project, only: [:index, :new, :create, :edit, :update]
  before_action :get_ticket, only: [:show, :edit, :update, :destroy, :assign_dev, :change_status]

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

    if params[:ticket][:dev_id].nil? || params[:ticket][:dev_id].empty?
      @ticket.dev_id = current_user.id
    else
      @ticket.dev_id = params[:ticket][:dev_id]
    end

    if @ticket.save
      save_attachments
      redirect_to dashboard_path(@project)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      save_attachments
      redirect_to dashboard_path(@ticket.project)
    else
      render 'edit'
    end
  end

  def change_status
    case params[:status]
      when "To do"
        @ticket.update(:status => params[:status])
      when "In progress"
        if @ticket.status == "Dev complete"
          @ticket.update(:status => params[:status])
        else
          @ticket.update(:status => params[:status], :start_at => Time.now)
        end
      when "Dev complete"
        @ticket.update(:status => params[:status], :completed_at => Time.now)
      when "Done"
        @ticket.update(:status => params[:status], :end_at => Time.now)
      else
        raise "invalid status"
    end
    redirect_to dashboard_path(@ticket.project)
  end

  def destroy
    @project = @ticket.project
    @ticket.destroy
    redirect_to dashboard_path(@project)
  end

  private
    def ticket_params
      params.require(:ticket).permit(:title, :description, :attachment, :project_id, :dev_id, :priority, :status, :task_id, :type)
    end

    def get_project
      @project = Project.find(params[:project_id])
    end

    def get_ticket
      @ticket = Ticket.find(params[:id])
    end

    def save_attachments
      params.require(:ticket).permit(:files => [])
      
      unless params[:ticket][:files].nil?
        params[:ticket][:files].each do |file|
          @attachment = Attachment.new(user_id: current_user.id, file: file)
     
          if @attachment.save
            @project.attachments << @attachment
            @ticket.attachments << @attachment
          else
            render 'new'
          end
        end
      end
    end

end
