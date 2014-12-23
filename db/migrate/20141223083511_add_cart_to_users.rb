class AddCartToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :cart_id, :integer, index: true
  end
end
