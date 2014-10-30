class AddressesController < ApplicationController
  
  include CurrentCart
  
  before_action :set_cart
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authorize
#  before_action :check_if_user_already_has_billing_address, only: [:create, :update]
  after_action  :remove_previous_default_address, only: [:create, :update]
  	

  # GET /addresses
  # GET /addresses.json
  def index
	   session[:redirect_to_address]=nil 
	   @addresses = @current_user.addresses
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    
    @city = City.find(params[:address][:city_id])
    @address = @city.addresses.new(address_params.merge(user_id: @current_user.id))
    
    if params[:billing] 
      if @current_user.has_billing_address?
        return
        redirect_to addresses_path, notice: 'You can add only one billing address.'
      else
        @address.billing = params[:billing]
      end
    end
    
    respond_to do |format|
      if @address.save
        format.html { redirect_to addresses_path, notice: 'Address was successfully created.' }
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
        format.html { redirect_to addresses_path, notice: 'Address was successfully updated.' }
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
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  def new_billing_address
    @address = Address.new
  end
  
  
  def user_addresses
    @user_addresses = @current_user.addresses
    
  end
  
  
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:street_name, :street_number, :shipping_default, :billing, :user_id, :first_name, :last_name, :details)
    end
	 
      def check_if_user_already_has_billing_address
      if @current_user.has_billing_address?
        redirect_to addresses_path, notice: 'You can add only one billing address.'
      end
    end
  
  # before this action, user will have 2 default shipping addresses
  # this action will remove users previous default address
  def remove_previous_default_address
    if @address.shipping_default == true
      previous_default_address = @current_user.addresses.where(shipping_default: true).where.not(id: @address.id).first
      if previous_default_address
        previous_default_address.shipping_default = false
        previous_default_address.save
      end
    end
    
    # if user has no default shipping address, his billing address will be default
    if @address.billing == true && @current_user.addresses.where(default_shipping: true)
      @address.shipping_default = true
    end
      
  end
	


end
