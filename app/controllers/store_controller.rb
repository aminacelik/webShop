class StoreController < ApplicationController
	skip_before_action :authorize
	
	layout 'homepage_layout'
	
	include CurrentCart
	before_action :set_cart
	
 	def index
		@products = Product.last(8)
  	end
end
