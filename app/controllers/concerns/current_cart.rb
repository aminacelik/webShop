module CurrentCart
    extend ActiveSupport::Concern
    
    private
    
    def set_cart
		unless session[:role]=='administrator'
			@cart = Cart.find(session[:cart_id])
		end
		rescue ActiveRecord::RecordNotFound
			@cart = Cart.create
			session[:cart_id] = @cart.id
		end 
  
  
	end
