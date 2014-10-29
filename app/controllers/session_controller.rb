class SessionController < ApplicationController
	
  include SessionHelper
  include CurrentCart
	
	before_action :set_cart
		
  skip_before_action :authorize
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      set_session_for_user(user)
	
	  if session[:role] == 'administrator'
		  redirect_to products_url, notice: "Logged in!"
	  else 
		  id = @cart.id
		  redirect_to addresses_url and return if session[:redirect_to_address]
		  redirect_to store_url, notice: "Logged in!"
	  end
		
    else
      redirect_to login_url, alert: "Invalid user/password combination."
    end
  end

  def destroy
	  session[:user_id]= nil
	  session[:role] = nil
	  redirect_to store_url, notice: "Goodbye!"
  end
end
