class UsersController < ApplicationController
  
	include CurrentCart
	include SessionHelper
		
	before_action :set_cart
  before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :limit_access_to_administrator, only: [:index]
  skip_before_action :authorize, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
	  @addresses = @user.addresses.where(order_id: nil)
  end

  # GET /users/new
  def new
	
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
#	lista za izbor role se prikazuje samo ako je logovan administrator
	if params[:user][:role_id]
		@role = Role.find(params[:user][:role_id])
	else
		@role = Role.find_by(name: 'registered user');
	end
	@user = @role.users.build(user_params)
	
    
    
  respond_to do |format|
    if @user.save

      set_session_for_user(@user)
      UserNotifier.welcome(@user).deliver

      format.html { 
        redirect_to addresses_url and return if session[:redirect_to_address]
        redirect_to @user, alert: t('status_mssg.user.created') 
      }
      format.json { render :show, status: :created, location: @user }
    else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
	
    
    
end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t('status_mssg.user.updated_html') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('status_mssg.user.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
		if(session[:role]=='administrator')
      @user = User.find(params[:id])
		else
			@user = @current_user
		end
    end
	  


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :role_id, :email)
    end
	

end
