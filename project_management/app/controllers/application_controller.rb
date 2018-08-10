class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  layout "application"
  before_action :authenticate_user!

  def save_attachments(container, files)
	  
	unless files.nil?
	  files.each do |file|
	    @attachment = container.attachments.new(user_id: current_user.id, file: file)
	      
	    if @attachment.save
	      container.attachments << @attachment
	    else
	      render 'new'
	    end
	  end
	end
  end
end
