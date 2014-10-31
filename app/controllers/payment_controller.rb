class PaymentController < ApplicationController
	before_action :authorize
	
	include CurrentCart
	before_action :set_cart

		

	def do_payment
	 
		puts "PaymentController::do_payment params= #{params.inspect}"
		Stripe.api_key = CFG["secret_key"]
			
	  customer = Stripe::Customer.create(
															:email => 'example@stripe.com',
															:card  => params[:stripeToken]
	  )			
	
		puts "customer = #{customer.inspect}"
			
		charge = Stripe::Charge.create(
																:customer    => customer.id,
																:amount      => (@cart.total_delivery_and_products_price*100).to_i,
																:description => 'Rails Stripe customer',
																:currency    => 'usd'
	  )	
		
			
		puts "charge = #{charge.inspect}"
		
    @cart.destroy
		render 'charges/confirmation'
			
	end
	
		
		
		
	def create
			
	
	  customer = Stripe::Customer.create(
		:email => 'example@stripe.com',
		:card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
		:customer    => customer.id,
		:amount      => @amount,
		:description => 'Rails Stripe customer',
		:currency    => 'usd'
	  )

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end
	
end
