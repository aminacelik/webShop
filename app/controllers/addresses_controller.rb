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
    
 
    @default_billing = @current_user.default_billing_address
    if @default_billing.nil?
      @new_billing= Address.new
    end
    @default_shipping = @current_user.default_shipping_address
    if @default_shipping.nil?
      @new_shipping= Address.new
    end

    if @default_billing && @default_shipping && (@default_billing == @default_shipping)
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
    @shipping_type = AddressType.where(name: 'shipping')
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


  
  
  def user_addresses
    @user_addresses = @current_user.addresses.where.not(default: true)
    
  end
  
  
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:street_name, :street_number, :shipping, :billing, :user_id, :first_name, :last_name, :details, :default)
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
