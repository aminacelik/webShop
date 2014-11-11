class ProductTranslationsController < ApplicationController
  before_action :set_product_translation, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :limit_access_to_administrator

  # GET /product_translations
  # GET /product_translations.json
  def index
    @product_translations = ProductTranslation.all
  end

  # GET /product_translations/1
  # GET /product_translations/1.json
  def show
  end

  # GET /product_translations/new
  def new
    @languages = Language.all
    @products = Product.all
    @product_translation = ProductTranslation.new
  end

  # GET /product_translations/1/edit
  def edit
  end

  # POST /product_translations
  # POST /product_translations.json
  def create
    @language = Language.where(id: params[:product_translation][:language_id]).first
    @product = Product.where(id: params[:product_translation][:product_id]).first
    @product_translation = @product.product_translations.new(product_translation_params.merge(language_id: @language.id))

    respond_to do |format|
      if @product_translation.save
        format.html { redirect_to @product_translation, notice: 'Product translation was successfully created.' }
        format.json { render :show, status: :created, location: @product_translation }
      else
        format.html { render :new }
        format.json { render json: @product_translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_translations/1
  # PATCH/PUT /product_translations/1.json
  def update
    respond_to do |format|
      if @product_translation.update(product_translation_params)
        format.html { redirect_to @product_translation, notice: 'Product translation was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_translation }
      else
        format.html { render :edit }
        format.json { render json: @product_translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_translations/1
  # DELETE /product_translations/1.json
  def destroy
    @product_translation.destroy
    respond_to do |format|
      format.html { redirect_to product_translations_url, notice: 'Product translation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_translation
      @product_translation = ProductTranslation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_translation_params
      params.require(:product_translation).permit(:language_id, :product_id, :title, :description, :price)
    end
end
