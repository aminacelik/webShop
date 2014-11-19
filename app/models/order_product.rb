class OrderProduct < ActiveRecord::Base
  belongs_to :category

  has_many :order_product_variants
  has_one :order_product_image

  def get_image
  	order_product_image.get_image
  end
end
