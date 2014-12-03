class LineItem < ActiveRecord::Base
  belongs_to :product_variant
  belongs_to :cart
	
  def total_price
	  product_variant.product.price * quantity
  end
	
  def get_product
	  product_variant.product
  end



  def get_image
    product_variant.get_product_image
  end
end
