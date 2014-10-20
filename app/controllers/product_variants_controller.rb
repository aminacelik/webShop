class ProductVariantsController < ApplicationController
  before_action :set_product_variant, only: [:show, :edit, :update, :destroy]

  # GET /product_variants
  # GET /product_variants.json
  def index
	 @product = Product.find(params[:product_id])    
	 @product_variants = @product.product_variants
  end

  # GET /product_variants/1
  # GET /product_variants/1.json
  def show
  end

  # GET /product_variants/new
  def new
	@product = Product.find(params[:product_id])
	@all_sizes = Size.all
    @product_variant = ProductVariant.new
  end

  # GET /product_variants/1/edit
  def edit
  end

  # POST /product_variants
  # POST /product_variants.json
  def create
	@product = Product.find(params[:product_id])

	@product_variant = @product.product_variants.new(product_variant_params.merge(size_id: params[:product_variant][:size_id], color_id: params[:product_variant][:color_id]))
	   respond_to do |format|
		  if @product_variant.save
			format.html { redirect_to product_variants_url(product_id: @product.id) }
			format.json {  }
		  else
			format.html { render :new }
			format.json { render json: @product_variant.errors, status: :unprocessable_entity }
		  end
	   end
	
end

  # PATCH/PUT /product_variants/1
  # PATCH/PUT /product_variants/1.json
  def update
    respond_to do |format|
      if @product_variant.update(product_variant_params)
        format.html { redirect_to @product_variant, notice: 'Product variant was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_variant }
      else
        format.html { render :edit }
        format.json { render json: @product_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_variants/1
  # DELETE /product_variants/1.json
  def destroy
    @product_variant.destroy
    respond_to do |format|
      format.html { redirect_to product_variants_url, notice: 'Product variant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_variant
      @product_variant = ProductVariant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_variant_params
      params.require(:product_variant).permit(:product_id, :size_id, :color_id, :quantity)
    end
end
