class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :color
  belongs_to :order
    
	has_many :product_variants, dependent: :destroy
  has_many :product_translations, dependent: :destroy

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images
  validate :has_at_least_one_image

  validates :title, :description, :category_id, presence: true
  validates :price, :sale_price, numericality: {greater_than_or_equal_to: 0.01}
  
    
    
    def self.latest
        Product.order(:updated_at).last
    end
    
    def title
      if I18n.locale && I18n.locale != 'en'
        @language = Language.where(short_name: I18n.locale).first
        @product_translation = product_translations.where(language_id: @language.id).first
        if @product_translation
          @product_translation.title
        end
      else
        read_attribute(:title)
      end
    end

    def description
      if I18n.locale == 'en'
        read_attribute(:description)
      else
        @language = Language.where(short_name: I18n.locale).first
        @product_translation = product_translations.where(language_id: @language.id).first
        if @product_translation
          @product_translation.title
        else
          read_attribute(:description)
        end
      end
    end

    def category_name
      category.name 
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

    def has_only_one_image?
      product_images.count == 1
    end

    def discount_percent
      percent = sale_price * 100 / price
      percent = 100 - percent 
      percent.round(1)
    end

    def self.highest_discount
      products_on_sale = Product.where.not(sale_price: nil)
      highest_discount = 0
      products_on_sale.each do |prod|
        if prod.discount_percent > highest_discount
          highest_discount = prod.discount_percent
        end
      end
      highest_discount
    end

    def on_sale?
      !sale_price.nil?
    end

    def sold_out?
      product_variants.each do |v|
        if v.quantity > 0
          return false
        end
      end
      true
    end

end