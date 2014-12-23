class RemoveCartDataFromAdminUsers < ActiveRecord::Migration
  def change
  	User.find_each do |user|
	  	if user.role.name == 'administrator'
	  		user.cart_id = nil
	  		user.save!
	  	end
	end
  end
end
