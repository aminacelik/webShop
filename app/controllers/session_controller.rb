class SessionController < ApplicationController
	
  skip_before_action :authorize
	include CurrentCart
	before_action :set_cart
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
	  session[:role] = user.role.name
	
	  if session[:role]=='administrator'
		  redirect_to products_url, notice: "Logged in!"
	  else 
		  id = @cart.id
		  if session[:url] == "/carts/#{id}"
			  redirect_to addresses_url, notice: 'You are logged in. Now choose your address.'
		  else
		  redirect_to store_url, notice: "Logged in!"
		  end
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
