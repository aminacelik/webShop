class Cart < ActiveRecord::Base

    has_many :line_items, dependent: :destroy
    
    has_one :user


    def all_in_cart?(product_variant_id)
      line_item = find_line_item(product_variant_id)
      product_variant = ProductVariant.find(product_variant_id)
      
      conclusion = false
      if line_item && product_variant
        a = product_variant.quantity 
        b= line_item.quantity
      
        if a-b == 0 
          conclusion = true
        end
      end
      conclusion
      
    end
    
    def not_all_in_cart?(product_variant_id)
      !all_in_cart?(product_variant_id)
    end
  
    def add_product_variant(product_variant_id)
        line_item = find_line_item(product_variant_id)
        product_variant = ProductVariant.find(product_variant_id)
        
        if line_item
            line_item.quantity +=1
        else
            line_item = line_items.build(product_variant_id: product_variant_id)
        end
        line_item  
    end  
  
  def find_line_item(id)
      line_items.where(product_variant_id: id).first

  end

  def available_items?
    line_items.each do |li|
      if !li.product_variant.sold_out?
        return true
      end
    end
    false
  end
  
	
	def total_price
    total_price=0
    line_items.each do |li|
      if !li.product_variant.sold_out?
        total_price += li.total_price
      end
    end
    total_price
	end
	
	def number_of_products
    number_of_products=0
		line_items.each do |li|
      if !li.product_variant.sold_out?
        number_of_products += li.quantity
      end
    end
    number_of_products
	end
	
	def delivery_price
		number_of_products * 5
	end
	
	def total_delivery_and_products_price
		delivery_price + total_price
	end

  def items
    line_items
  end

  def available_items
    available_items = []
    line_items.each do |item|
      if item.product_variant.available?(item.quantity)
        available_items << item
      end
    end
    available_items
  end

	def all_cart_items_are_not_available?
    return items.count != available_items.count
	end
    
end
