class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :limit_access_to_administrator, except: [:show] #unregistered user can access only :show
  skip_before_action :authorize, only: [:show]
  
  include CurrentCart
  before_action :set_cart
	
	
	

  # GET /products
  # GET /products.json
  def index
    @products = Product.where(order_id: nil)
  end

  # GET /products/1
  # GET /products/1.json
  def show
	  @similar_products = Product.where(category_id: @product.category.id, order_id: nil).last(4)
	  @variants = ProductVariant.where(product_id: @product.id, order_id: nil)
	  
	  @sizes = []
	  @variants.each do |var| 
      if var.quantity > 0
		    @sizes << var.size
      end
	  end
	  
    if params[:locale] == 'ba'
      @language = Language.where(short_name: 'ba').first
      @translation = @product.product_translations.where(language_id: @language.id).first
    end

    @images = @product.product_images

  end

  # GET /products/new
  def new
    @product = Product.new
    @product_image = ProductImage.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create

	  @category = Category.where(id: params[:product][:category_id]).first
    @product = @category.products.build(product_params)
    @product_image = @product.product_images.build(image: params[:product][:image])

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_detailed_show_url(id: @product.id), notice: t('status_mssg.product.created') }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: t('status_mssg.product.updated_html') }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: t('status_mssg.product.deleted') }
      format.json { head :no_content }
    end
  end

  def detailed_show
    @product = Product.find(params[:id])
    @images = @product.product_images
    @variants = ProductVariant.where(product_id: @product.id, order_id: nil).order('size_id ASC')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id)
    end

end
