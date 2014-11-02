class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :find_current_user
  before_action :authorize, :find_categories
  
  def find_categories
	  @categories = Category.all
  end

  def find_current_user
	  if(session[:user_id])
		  @current_user = User.where(id: session[:user_id]).first
	  end
  end
	
protected 
	
	# provjerava da li je logovan user
  def authorize
	  
	  
	  
	  puts "CONTROLLER : #{params.inspect}"
	  
	  
	  unless (session[:user_id])
	  	session[:redirect_to_address] = true if params[:action] == "index" && params[:controller] == "addresses"
		redirect_to login_url, alert: "Before seeing this page you have to log in."
	  end
	  
  end

	# za stranice kojima pristup treba imati samo administrator
  def limit_access_to_administrator
	  unless session[:role] == "administrator"
		  redirect_to store_url, notice: "You are not allowed to access this page."
	  end
  end
end
