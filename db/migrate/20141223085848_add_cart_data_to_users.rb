class AddCartDataToUsers < ActiveRecord::Migration
  def change
  	Cart.delete_all
	  User.find_each do |user|
	  	cart = Cart.create!
	  	user.cart_id = cart.id
	  	user.save!
	  end
  end
end
