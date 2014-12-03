class ProductVariant < ActiveRecord::Base
  belongs_to :product
  belongs_to :size
  belongs_to :color
  belongs_to :order
  
  has_many :line_items
	
  # before_destroy :ensure_not_referenced_by_any_line_item
	
  def get_product_image
    product.get_medium_image
  end

  def get_product_color
    color.name
  end

  def get_product_size
    size.size
  end

  def get_product_title
    product.title 
  end

  def get_product_price
    product.price 
  end

  def sold_out?
    quantity <= 0
  end

  def available?(number_of_products)
    quantity >= number_of_products
  end


	private
	
	 def ensure_not_referenced_by_any_line_item
        if line_items.empty?
            return true
        else
            errors.add(:base, 'Line Items present.')
            return false
        end
    end
end
