class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
	
  def total_price
	  product.price * quantity
  end
	
  def get_product
	  product
  end
end
