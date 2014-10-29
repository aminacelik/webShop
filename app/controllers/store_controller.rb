class StoreController < ApplicationController
	skip_before_action :authorize
	

	
	include CurrentCart
	before_action :set_cart
	
 	def index
		@products = Product.last(8)
  	end
end
