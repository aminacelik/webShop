class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  
	include CurrentCart
	before_action :set_cart
#	before_action :remove_default_address, only: [:create, :update, :make_default_address]
	
	
  # GET /addresses
  # GET /addresses.json
  def index
	@shipping_type = AddressType.where(name: 'shipping').first
	@billing_type = AddressType.where(name: 'billing').first
    @shipping_addresses = @current_user.addresses.where(address_type_id: @shipping_type.id)
	@billing_address = @current_user.addresses.where(address_type_id: @billing_type.id).first
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
	@address_type = AddressType.find(params[:address][:address_type_id])
	  
	@billing_address_type = AddressType.where(name: 'billing').first
	  if params[:address][:address_type_id] == @billing_address_type.id
		  remove_billing_address
	  end
#	for now we dont have to worry about default address. 
	@address = @city.addresses.new(address_params.merge(user_id: @current_user.id, address_type_id: @address_type.id))


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
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:street_name, :street_number, :floor, :flat, :default, :user_id, :address_type_id)
    end
	
	
#	def remove_default_address
#	  @all_user_addresses = @current_user.addresses
#	  @all_user_addresses.each do |adr|
#		  if adr.default == true
#			  adr.default = false
#			  adr.save
#		  end
#	  end
#	end
#	
#	def make_default_address(id)
#		@new_default_address = @current_user.addresses.where(id: id)
#		@new_default_address.default = true
#		@new_default_address.save
#	end
#	
	#user is allowed to have only one billing address
	def remove_billing_address
		@billing_address_type = AddressType.where(name: 'billing').first
		@address = @current_user.addresses.where(address_type_id: @billing_address_type.id)
		@address.destroy
	end
	

end
