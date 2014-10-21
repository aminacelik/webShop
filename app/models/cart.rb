class Cart < ActiveRecord::Base

    has_many :line_items, dependent: :destroy
    
    
    def add_product_variant(product_variant_id)
        current_item = line_items.find_by(product_variant_id: product_variant_id)
        
        if current_item
            current_item.quantity +=1
        else
            current_item = line_items.build(product_variant_id: product_variant_id)
        end
        current_item  
    end    
	
	def total_price
#		line_items.to_a.sum { |item| item.total_price }
		line_items.to_a.sum(&:total_price)
	end
	
	def number_of_products
		line_items.sum(:quantity)
	end
	
	def delivery_price
		number_of_products * 5
	end
	
	def total_delivery_and_products_price
		delivery_price + total_price
	end
    
end
