class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :find_current_user
  before_action :authorize
  
  def find_current_user
	  if(session[:user_id])
		@current_user = User.find(session[:user_id])
	  end
  end
	
protected 
  def authorize
	  unless @current_user
		  redirect_to login_url, alert: "Before seeing this page you have to log in."
	  end
  end

	
  def limit_access_to_administrator
	  unless @current_user.role.name == "administrator"
		  redirect_to store_url, notice: "You are not allowed to access this page."
	  end
  end
end
