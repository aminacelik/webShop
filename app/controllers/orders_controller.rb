class OrdersController < ApplicationController
  
  include CurrentCart

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_cart

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
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
    do_payment
    price = @cart.total_delivery_and_products_price
    @order = Order.new(user_id: @current_user.id, price: price)

    respond_to do |format|
      if @order.save
        format.html { redirect_to 'charges/confirmation', notice: 'Order was successfully created.' }
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
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
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
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def create_order
    do_payment
    price = @cart.total_delivery_and_products_price
    @order = Order.new(user_id: @current_user.id, price: price)
    @order.save


    save_shipping_address_copy
    save_billing_address_copy
    save_items_copy

    @line_items = @cart.line_items
    @line_items.delete_all  

    render 'charges/confirmation'
  end


  private

   

    def save_shipping_address_copy
      @address = Address.where(id: session[:shipping_id]).first
      @address_copy = Address.new(street_name: @address.street_name,
                                   street_number: @address.street_number,
                                   details: @address.details,
                                   user_id: @address.user_id,
                                   city_id: @address.city_id,
                                   first_name: @address.first_name,
                                   last_name: @address.last_name,
                                   shipping: true,
                                   order_id: @order.id)
      @address_copy.save
    end

    def save_billing_address_copy
      @address = Address.where(id: session[:billing_id]).first
      @address_copy = Address.new(street_name: @address.street_name,
                                   street_number: @address.street_number,
                                   details: @address.details,
                                   user_id: @address.user_id,
                                   city_id: @address.city_id,
                                   first_name: @address.first_name,
                                   last_name: @address.last_name,
                                   billing: true,
                                   order_id: @order.id)
      @address_copy.save
    end
  

    def save_items_copy
      @cart_items = @cart.line_items

      @cart_items.each do |item|
      
        @product_variant = item.product_variant
        @product = @product_variant.product

        @product_copy = Product.new(title: @product.title, 
                                    description: @product.description, 
                                    image_url: @product.image_url, 
                                    price: @product.price, 
                                    category_id: @product.category_id, 
                                    order_id: @order.id)
        @product_copy.save

        # quantity management
        @product_variant.quantity -= item.quantity
        @product_variant.save

        @product_variant_copy = ProductVariant.new(product_id: @product_copy.id,
                                                   size_id: @product_variant.size.id,
                                                   color_id: @product_variant.color.id,
                                                   quantity: item.quantity,
                                                   order_id: @order.id)
        @product_variant_copy.save



        
      end
    end


      def do_payment
       
        puts "PaymentController::do_payment params= #{params.inspect}"
        Stripe.api_key = CFG["secret_key"]
          
        customer = Stripe::Customer.create(
        :email => @current_user.email,
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
        

      # creating order
      # price = @cart.total_delivery_and_products_price
     #    @order = Order.create(user_id: @current_user.id, price: price)


      
          
      end


    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :price, :shipping_address_id, :billing_address_id)
    end
end