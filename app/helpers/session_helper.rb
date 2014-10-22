module SessionHelper
	def set_session_for_user(user)
		session[:user_id] = user.id
	  	session[:role] = user.role.name
	end
end
