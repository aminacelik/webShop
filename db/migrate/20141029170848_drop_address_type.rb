class DropAddressType < ActiveRecord::Migration
  def change
    drop_table :address_types
  end
end
