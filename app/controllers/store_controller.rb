class StoreController < ApplicationController
	skip_before_action :authorize
	 layout "homepage"

	
	include CurrentCart
	before_action :set_cart
	
 	def index
 		if params[:set_locale]
 			redirect_to store_url(locale: params[:set_locale]), notice: t('status_mssg.store.language_changed_html')
 		else
			@products = Product.last(8)
		end
  	end

  	
end
