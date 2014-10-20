class ProductVariant < ActiveRecord::Base
  belongs_to :product
  belongs_to :size
  belongs_to :color
	
end
