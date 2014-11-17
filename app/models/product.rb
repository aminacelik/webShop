class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :color
  belongs_to :order
    
	has_many :product_variants
  has_many :product_translations
  has_many :product_images

	validates :category, associated: true
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
   
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a URL for GIF, JPG or PNG image.'
    }
    
    before_destroy :ensure_not_referenced_by_any_line_item
    
    def self.latest
        Product.order(:updated_at).last
    end
    
    def get_title_translation(short_name)
      @language = Language.where(short_name: short_name).first
      @product_translation = product_translations.where(language_id: @language.id).first
      if @product_translation
        @product_translation.title
      else
        title
      end
    end
  
   
    
   
    
end
