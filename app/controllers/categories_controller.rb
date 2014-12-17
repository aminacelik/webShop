class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:show]
	
  include CurrentCart
  before_action :set_cart
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @products = @category.products.where(nil) # creates an anonymous scope
    puts " #1 @products : #{@products.count}" 
    # product price filtering
    @products = @products.more_expensive_than(params[:min_price]) if !params[:min_price].blank? && params[:min_price].to_i >=0
    puts " #2 @products : #{@products.count}" 
    @products = @products.cheaper_than(params[:max_price]) if !params[:max_price].blank? && params[:max_price].to_i >=0
    puts " #3 @products : #{@products.count}" 
    # product variant size and color filtering
    @products = @products.with_size_id(params[:size]) if !params[:size].blank?
    puts " #4 @products : #{@products.count}" 
    @products = @products.with_color_id(params[:color]) if !params[:color].blank?
    puts " #5 @products : #{@products.count}" 


  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
