class AddressesController < ApplicationController
  
  include CurrentCart

  before_action :set_cart
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  after_action :set_default_address, only: [:create]

  # GET /addresses
  # GET /addresses.json
  def index
	   session[:redirect_to_address]=nil 
# First we are searching addresses selected by session variables

    @selected_shipping = Address.where(id: session[:shipping_id]).first
    @selected_billing = Address.where(id: session[:billing_id]).first

# If we dont find any, we are trying to find default addresses
    if @selected_shipping.nil?
      @selected_shipping = @current_user.default_shipping_address
    end
    
    if @selected_billing.nil?
      @selected_billing = @current_user.default_billing_address
    end

# If the user has no default addresses, we are offering a form for creating them
# And if he has, we are selecting that address
    if @selected_shipping.nil?
      @new_shipping= Address.new
    else
      session[:shipping_id] = @selected_shipping.id
    end
    
    if @selected_billing.nil?
      @new_billing= Address.new
    else
      session[:billing_id] = @selected_billing.id
    end

# If the user has selected the same shipping adn billing addresses, we are showing just one
    if @selected_billing && @selected_shipping && (@selected_shipping == @selected_billing)
      @the_same_addresses = true
    else
      @the_same_addresses = false
    end
end


  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @new_shipping = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create

    @address = Address.new(address_params.merge(user_id: @current_user.id))
    @city = City.find(params[:address][:city_id])
    if @city
      @address.city_id = @city.id
    end

    
    respond_to do |format|
      if @address.save
          if @address.shipping == true
            session[:shipping_id] = @address.id
          else
            session[:billing_id] = @address.id
          end
    

        format.html { redirect_to addresses_path, notice: t('status_mssg.address.created') }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end
  


  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to addresses_path, notice: t('status_mssg.address.updated_html') }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: t('status_mssg.address.deleted') }
      format.json { head :no_content }
    end
  end

  def new_billing_address
    @new_billing = Address.new
  end
  
  
  def user_addresses
    @user_addresses = @current_user.addresses
    @address_type = params[:type]
  end
  
  def select_address
    address = Address.where(id: params[:id]).first

    if params[:type] == 'shipping'
      session[:shipping_id] = address.id
    end
    if params[:type] == 'billing'
      session[:billing_id] = address.id
    end
    redirect_to addresses_path, notice: t('status_mssg.address.selected')
  end
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:street_name, :street_number, :details, :shipping, :billing, :default, :user_id, :city_id, :first_name, :last_name)
    end
	 
  
	
  def set_default_address
    default_shipping = @current_user.default_shipping_address
    default_billing = @current_user.default_billing_address

    unless default_shipping
      @address.default = true
      @address.save
    end

    unless default_billing
      @address.default = true
      @address.save
    end
      
  end
      





end
