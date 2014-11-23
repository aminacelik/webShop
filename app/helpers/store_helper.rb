module StoreHelper

	def items_on_sale_images
		products = Product.where.not(sale_price: nil)
		@on_sale_images = []

		products.each do |p|
			@on_sale_images << p.product_images.first
		end
		@on_sale_images
	end
end
