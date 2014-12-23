class Order < ActiveRecord::Base
	belongs_to :user

	has_many :order_product_variants


	def get_shipping_address
		OrderAddress.where(id: shipping_address_id).first
	end

	def get_billing_address
		OrderAddress.where(id: billing_address_id).first
	end

	def get_order_date
		created_at.to_date.strftime("%d.%m.%Y.")
	end
  
  def get_shipping_date
    updated_at.to_date.strftime("%d.%m.%Y.")
  end
  
  def get_user_name
    user.name
  end
  
  def get_user_email
    user.email
  end

  def items
  	order_product_variants
  end

  def number_of_items
    items.count
  end

  def status
    if shipped == true
      return "shipped"
    else 
      return "not shipped yet"
    end
  end


end
