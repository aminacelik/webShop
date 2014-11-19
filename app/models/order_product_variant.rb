class OrderProductVariant < ActiveRecord::Base
  belongs_to :order_product
  belongs_to :size
  belongs_to :color
  belongs_to :order

 def get_product_color
    color.name
  end

  def get_product_size
    size.size
  end

  def get_product_title
    order_product.title 
  end

  def get_product_price
    order_product.price 
  end

  def get_order_product_image
    order_product.get_image
  end

end
