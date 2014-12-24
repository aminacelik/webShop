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
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validate  :sale_price_lesser_than_original_price


  scope :cheaper_than, lambda { |price| where("price <= ? or sale_price <= ?", price, price) } 
  scope :more_expensive_than, lambda { |price| where("price >= ? or sale_price <= ?", price, price) } 
  scope :with_size_id, lambda { |size_id| joins(:product_variants).merge(ProductVariant.with_size_id(size_id)) } 
  scope :with_color_id, lambda { |color_id| joins(:product_variants).merge(ProductVariant.with_color_id(color_id)) } 


# validation methods
    def sale_price_lesser_than_original_price
      if sale_price
        errors.add(:sale_price, 'must be lesser than original price') if sale_price >= read_attribute(:price)
      end
    end

    def self.latest
        Product.order(:updated_at).last
    end

	  def has_at_least_one_image
      errors.add(:product_images, 'must have at least one image') if self.product_images.blank?
    end


# attribute override methods
    def title
      if I18n.locale == 'en'
        read_attribute(:title)
      else
        language = Language.where(short_name: I18n.locale).first
        if language
          product_translation = product_translations.where(language_id: language.id).first
          if product_translation
            product_translation.title
          else
            read_attribute(:title)
          end
        else
          read_attribute(:title)
        end
      end
    end

    def description
      if I18n.locale == 'en'
        read_attribute(:description)
      else
        language = Language.where(short_name: I18n.locale).first
        if language
          product_translation = product_translations.where(language_id: language.id).first
          if product_translation
            product_translation.description
          else
            read_attribute(:description)
          end
        else
          read_attribute(:description)
        end
      end
    end

	 def price
    if read_attribute(:sale_price) != nil
      price = sale_price
    else
      price = old_price
    end			
  end
	
	
  def old_price
    if I18n.locale.to_s == 'ba'
      currency = Currency.where(name: 'BAM').first
      if currency
        price = read_attribute(:price) * currency.exchange_rate
      else
        price = read_attribute(:price)
      end
    else
      price = read_attribute(:price)
    end
    price
  
  end

  def sale_price
    if I18n.locale.to_s == 'ba'
      currency = Currency.where(name: 'BAM').first
      if currency
        price = read_attribute(:sale_price) * currency.exchange_rate
      else
        price = read_attribute(:sale_price)
      end
    else
      price = read_attribute(:sale_price)
    end
    price
   
  end
	

	
	# other
	
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

    def get_background_image
      if product_images.present?
        product_images.first.image.url(:large)
      end
    end


    def has_only_one_image?
      product_images.count == 1
    end

    def discount_percent
      percent = read_attribute(:sale_price) * 100 / read_attribute(:price)
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
      if read_attribute(:sale_price)
        return read_attribute(:sale_price) < read_attribute(:price)
      end
      false
    end

    def sold_out?
      product_variants.each do |v|
        if !v.sold_out?
          return false
        end
      end
      true
    end
  
  # method used to decide wheather to show product variant size in size selector
    def available_sizes(cart_id)
      cart = Cart.where(id: cart_id).first
      sizes = []
      product_variants.each do |var| 
        if var.quantity > 0 && cart.not_all_in_cart?(var.id)
		      sizes << var.size
        end
	    end
      sizes
    end
	
	def sizes
		sizes = []
		product_variants.each do |var|
			sizes << var.size
		end
		sizes
	end

  def has_size?(size_id)
    variants = product_variants.where(size_id: size_id)
    return variants.empty?
  end
	

end