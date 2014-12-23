module SessionHelper
	def set_session_for_user(user)
		session[:user_id] = user.id
	  	session[:role] = user.role.name

	  	cart = Cart.where(id: user.cart.id).first
	  	session[:cart_id] = cart.id
	end
end
