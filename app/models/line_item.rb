class LineItem < ActiveRecord::Base
  belongs_to :product_variant
  belongs_to :cart
	
  def total_price
	  product_variant.product.price * quantity
  end
	
  def get_product
	  product_variant.product
  end

  def get_product_title
    get_product.title
  end

  def get_image
    product_variant.get_product_image
  end

  def get_size
    product_variant.get_product_size
  end

  def get_color
    product_variant.get_product_color
  end

  def sold_out?
    product_variant.sold_out?
  end

  def get_price
    get_product.price
  end

  def availability(number_of_products)
    product_variant.availability(number_of_products)
  end
end
