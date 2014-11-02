class AddBillingDefaultToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :billing_default, :boolean, index: true, default: false
  end
end
