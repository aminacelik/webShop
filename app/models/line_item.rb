class LineItem < ActiveRecord::Base
  belongs_to :product_variant
  belongs_to :cart
	
  def total_price
	  product_variant.product.price * quantity
  end
	
  def get_product
	  product_variant.product
  end
end
