class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :find_user, :authorize
  
  def find_user
	  if(session[:user_id])
		@user = User.find(session[:user_id])
	  end
  end
	
  def authorize
	  unless User.find(session[:user_id])
		  redirect_to login_url, notice: "Please log in"
	  end
  end
	
end
