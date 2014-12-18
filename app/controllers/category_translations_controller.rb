class CategoryTranslationsController < ApplicationController
  before_action :set_category_translation, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :limit_access_to_administrator
	before_action :set_category

  # GET /category_translations
  # GET /category_translations.json
  def index
    @category = Category.find(params[:id])
    @category_translations = @category.category_translations
  end

  # GET /category_translations/1
  # GET /category_translations/1.json
  def show
  end

  # GET /category_translations/new
  def new
    @languages = Language.all
    @categories = Category.all
    @category_translation = CategoryTranslation.new
  end

  # GET /category_translations/1/edit
  def edit
  end

  # POST /category_translations
  # POST /category_translations.json
  def create

    @language = Language.where(id: params[:category_translation][:language_id]).first
    
    @category_translation = @category.category_translations.new(category_translation_params.merge(language_id: @language.id))

    respond_to do |format|
      if @category_translation.save
        format.html { redirect_to categories_detailed_show_path(id: @category.id), notice: 'Category translation was successfully created.' }
        format.json { render :show, status: :created, location: @category_translation }
      else
        format.html { render :new }
        format.json { render json: @category_translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_translations/1
  # PATCH/PUT /category_translations/1.json
  def update
    respond_to do |format|
      if @category_translation.update(category_translation_params)
        format.html { redirect_to categories_detailed_show_path(id: @category.id), notice: 'Category translation was successfully updated.' }
        format.json { render :show, status: :ok, location: @category_translation }
      else
        format.html { render :edit }
        format.json { render json: @category_translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_translations/1
  # DELETE /category_translations/1.json
  def destroy
    @category_translation.destroy
    respond_to do |format|
      format.html { redirect_to categories_detailed_show_path(id: @category.id), notice: 'Category translation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_translation
      @category_translation = CategoryTranslation.find(params[:id])
    end
	
	   def set_category
      @category = Category.find(params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_translation_params
      params.require(:category_translation).permit(:language_id, :category_id, :name)
    end
end
