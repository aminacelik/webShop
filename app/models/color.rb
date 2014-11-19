class Color < ActiveRecord::Base
	has_many :product_variants
	has_many :order_product_variants
end
