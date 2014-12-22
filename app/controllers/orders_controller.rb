class OrdersController < ApplicationController
  
  include CurrentCart

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_cart
  before_action :authorize
  before_action :limit_access_to_administrator, only: [:index]

  # GET /orders
  # GET /orders.json
  def index
    if params[:shipped]=='true'
      find_orders_items(true)
    else
      find_orders_items(false)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
 
    price = @cart.total_delivery_and_products_price
    @order = Order.new(user_id: @current_user.id, price: price)

    respond_to do |format|
      if @order.save
        format.html { redirect_to 'charges/confirmation', notice: t('status_mssg.order.created')}
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: t('status_mssg.order.updated_html') }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: t('status_mssg.order.deleted') }
      format.json { head :no_content }
    end
  end


  def purchase_confirmation
    @order = Order.where(id: session[:last_order]).first
    @order_items = @order.items
  end

  def purchase_history
    @user_orders = Order.where(user_id: @current_user.id).order('created_at DESC')
    @order_items = []
    @user_orders.each do |order|
      @order_items +=  order.items
    end
  end
  
    
  def available_items
    @cart_items = @cart.line_items
    if I18n.locale.to_s == 'ba'
      @currency = Currency.where(name: 'BAM').first
    else
      @currency = Currency.where(name: 'USD').first
    end
  end

  def ship_order
    order = Order.where(id: params[:id]).first
    order.shipped = true
    

    respond_to do |format|
      if order.save
        find_orders_items(false)
        format.html { redirect_to orders_url, notice: 'Order is now marked as shipped!'}
	      format.js
        format.json { head :no_content }
      end
    end
  end
    
  

  def create_order
    price = @cart.total_delivery_and_products_price
		
		if @cart.all_cart_items_are_not_available? 
			redirect_to orders_available_items_path and return
		end
		
    begin 
      ActiveRecord::Base.transaction do
        shipping_id = save_address_copy(session[:shipping_id])
        billing_id = save_address_copy(session[:billing_id])

        @order = Order.new(user_id: @current_user.id, price: price, shipping_address_id: shipping_id, billing_address_id: billing_id)
        @order.save


        save_items_copy

        # if everything goes fine, user credit card will be charged
        do_payment

        # deleting line items from cart
        @cart.line_items.delete_all  
       
        session[:last_order]=@order.id
        redirect_to orders_purchase_confirmation_path(id: @order.id), notice: t('status_mssg.order.ordered')
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to store_url, notice: "Something went wrong. We are sory about that."
    rescue ActiveRecord::ActiveRecordError
      redirect_to store_url, notice: "Not enough products in stock."
    end


  end

  private
	
	

  
  def find_orders_items(shipped_bool)
    orders = Order.where(shipped: shipped_bool).order('created_at ASC')
    @order_items = []
    orders.each do |order|
      @order_items +=  order.order_product_variants
    end
  end
    

   

    def save_address_copy(id)
      address = Address.find(id)
      address.lock!
      address_copy = OrderAddress.new(street_name: address.street_name,
                                      street_number: address.street_number,
                                      details: address.details,
                                      user_id: address.user_id,
                                      city_id: address.city_id,
                                      first_name: address.first_name,
                                      last_name: address.last_name)
      address_copy.save!
      address_copy.id
    end

  

    def save_items_copy
    
      @cart.line_items.each do |item|
      

        product_variant = item.product_variant
        raise ActiveRecord::RecordNotFound if product_variant.nil?
        product_variant.lock!

        product = product_variant.product 
        raise ActiveRecord::RecordNotFound if product.nil?
        product.lock!

        # saving product copy in order products table
        product_copy = OrderProduct.new(title: product.title, description: product.description, price: product.price, category_id: product.category_id)
        product_copy.save!

        # save copy of product image
        
        image_copy = OrderProductImage.new()
        image_copy.image = product.get_image_object
        image_copy.order_product_id = product_copy.id
        image_copy.save!

        # quantity management
        item.lock!

        # in stock more than user wants to order
        if product_variant.quantity >= item.quantity
          product_variant.quantity -= item.quantity
        # in stock less than user wants to order
        else
          raise ActiveRecord::ActiveRecordError
        end
          
        # raise ArgumentError if product_variant.quantity < 0
        product_variant.save!

        # saving product variant copy
        product_variant_copy = OrderProductVariant.new(order_product_id: product_copy.id, size_id: product_variant.size.id,
                                                      color_id: product_variant.color.id, quantity: item.quantity,
                                                      order_id: @order.id)
        product_variant_copy.save!
      end
    end


      def do_payment
       
        # puts "PaymentController::do_payment params= #{params.inspect}"
        Stripe.api_key = CFG["secret_key"]
          
        customer = Stripe::Customer.create(
        	:email => @current_user.email,
        	:card  => params[:stripeToken]
        )     
      
        # puts "customer = #{customer.inspect}"
          
        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => "500",
          :description => 'Rails Stripe customer',
          :currency    => 'usd'
        ) 
          
      end


    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :price, :shipping_address_id, :billing_address_id, :stripeEmail, :stripeToken)
    end
end
