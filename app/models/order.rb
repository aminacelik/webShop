class Order < ActiveRecord::Base
	belongs_to :user

	has_many :product_variants
	has_many :products 
	has_many :addresses


	def get_shipping_address
		Address.where(order_id: self.id, shipping: true).first
	end

	def get_billing_address
		Address.where(order_id: self.id, billing: true).first
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


end
