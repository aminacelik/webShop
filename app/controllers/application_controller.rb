class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_i18n_locale_from_params
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

  def set_i18n_locale_from_params
  	if params[:locale]
  		if I18n.available_locales.map(&:to_s).include?(params[:locale])
  			I18n.locale = params[:locale]
  		else
  			flash.now[:notice] = "The requested translation is not available."
  			logger.error flash.now[:notice]
  		end
  	end
  end

  def default_url_options
  	{ locale: I18n.locale }
  end

	# checks if user is logged in
  def authorize
	  unless (session[:user_id])
	  	session[:redirect_to_address] = true if params[:action] == "index" && params[:controller] == "addresses"
		redirect_to login_url, alert: t('.login_mssg')
	  end
  end


  def limit_access_to_administrator
	  unless session[:role] == "administrator"
		  redirect_to store_url, notice: t('.admin_mssg')
	  end
  end
end
