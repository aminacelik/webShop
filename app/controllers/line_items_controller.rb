class LineItemsController < ApplicationController
	
  skip_before_action :authorize, only: [:new, :create, :delete, :destroy]

  include CurrentCart
  
  before_action :set_cart
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
	  @product = line_item.get_product
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    
    product_variant = ProductVariant.where(product_id: params[:product_id], size_id: params[:size_id]).first
    @line_item = @cart.add_product_variant(product_variant.id)
	  @product = @line_item.product_variant.product
    
	  
    respond_to do |format|
      if @line_item.save
        @sizes = @product.available_sizes(@cart.id)
        format.html { redirect_to product_url(@product.id), notice: t('status_mssg.cart.added')}
		    format.js {}
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { redirect_to product_url(@product.id), notice: "Couldn't add to cart." }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
#	  set_cart
    respond_to do |format|
      format.html { redirect_to cart_url(@cart.id) }
	    format.js
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_variant_id, :cart_id, :size_id)
    end
end
