class TicketsController < ApplicationController
  before_action :get_project, only: [:index, :new, :create, :edit, :update]
  before_action :get_ticket, only: [:show, :edit, :update, :destroy, :assign_dev, :change_status, :files, :add_files, :comments, :bugs, :subtasks]

  def index
    @tickets = @project.tickets

  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = @project.tickets.new(ticket_params.merge(owner_id: current_user.id))

    if params[:ticket][:dev_id].nil? || params[:ticket][:dev_id].empty?
      @ticket.dev_id = current_user.id
    else
      @ticket.dev_id = params[:ticket][:dev_id]
    end
    
    params.require(:ticket).permit(:files => [])
    save_attachments(@ticket, params[:ticket][:files])

    if @ticket.save
      
      redirect_to dashboard_path(@project)
    else
      @ticket.attachments.each do |file|
        file.destroy
      end
      if @ticket.task_id.nil?
        render 'new'
      else
        flash[:error] = @ticket.errors.full_messages.join("<br>").html_safe
        redirect_to ticket_path(@ticket.task_id)
      end
    end
  end

  def edit
  end

  def update
    params.require(:ticket).permit(:files => [])
    save_attachments(@ticket, params[:ticket][:files])
    if @ticket.update(ticket_params)
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
        if @ticket.start_at.nil?
          @ticket.update(:status => params[:status], :start_at => Time.now)
        else
          @ticket.update(:status => params[:status])
        end
      when "Dev complete"
        @ticket.update(:status => params[:status], :completed_at => Time.now)
      when "Done"
        @ticket.update(:status => params[:status], :end_at => Time.now)
      else
        raise "invalid status"
    end
    #redirect_to dashboard_path(@ticket.project)
  end

  def destroy
    @project = @ticket.project
    @ticket.destroy
    redirect_to dashboard_path(@project)
  end

  def files
  end

  def bugs
  end

  def subtasks
  end

  def comments
  end

  def add_files
    params.require(:ticket).permit(:files => [])
    save_attachments(@ticket, params[:ticket][:files])
    redirect_to ticket_files_path(@ticket)
  end

  def undo
    @ticket = Ticket.order("updated_at").last
    if current_user.current_sign_in_at <= @ticket.updated_at
      if current_user.can_alter_ticket?(@ticket) 
        @ticket.versions.last.destroy
        @ticket = @ticket.paper_trail.previous_version
        @ticket.save   
      end
      redirect_to dashboard_path(@ticket.project)
    else
      redirect_to dashboard_path(@ticket.project)
    end  
  end

  private
    def ticket_params
      params.require(:ticket).permit(:owner_id, :title, :description, :attachment, :project_id, :dev_id, :priority, :status, :task_id, :type)
    end

    def get_project
      @project = Project.find(params[:project_id])
    end

    def get_ticket
      @ticket = Ticket.find(params[:id])
    end
end
