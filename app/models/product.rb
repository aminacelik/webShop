class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :color
  belongs_to :order
    
	has_many :product_variants
  has_many :product_translations

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images
  validate :has_at_least_one_image

  validates :title, :description, :category_id, presence: true
  validates :price, :sale_price, numericality: {greater_than_or_equal_to: 0.01}
  
    
    
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
    
    def get_image_object
      if product_images.present?
        product_images.first.image
      end
    end
   
    def get_thumb_image
      if product_images.present?
        product_images.first.image.url(:thumb)
      end
    end

    def get_medium_image
      if product_images.present?
        product_images.first.image.url(:medium)
      end
    end

    def get_large_image
      if product_images.present?
        product_images.first.image.url(:large)
      end
    end


    def has_at_least_one_image
      errors.add(:product_images, 'must have at least one image') if self.product_images.blank?
    end


end