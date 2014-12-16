class ProductsController < ApplicationController

  include CurrentCart

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :limit_access_to_administrator, except: [:show, :on_sale] 
  skip_before_action :authorize, only: [:show, :on_sale]
  before_action :set_cart

  # after_action :save_image, only: [:create, :update]

	

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
	  @similar_products = Product.where(category_id: @product.category.id).last(4)
	  @variants = ProductVariant.where(product_id: @product.id)
	  @sizes = []
    unless session[:role]=='administrator'
      @sizes = @product.available_sizes(@cart.id)
    else
      @sizes = @product.sizes
    end
	  
	  
	  

    if @product.has_only_one_image?
      @image = @product.product_images.first
    else
      @images = @product.product_images
    end

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

    @product = Product.new(product_params)
	  @category = Category.where(id: params[:product][:category_id]).first
    if @category
      @product.category_id = @category.id
    end

    if params[:product][:image]
      @product_image = @product.product_images.build(image: params[:product][:image])
    end

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
    @variants = ProductVariant.where(product_id: @product.id).order('size_id ASC')
  end

  def on_sale
    @products_on_sale = Product.where.not(sale_price: nil)
  end

  private

    def save_image

    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id, :sale_price)
    end

end
