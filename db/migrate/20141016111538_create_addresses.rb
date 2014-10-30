class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_name
      t.integer :street_number
      t.integer :floor
      t.string :flat
      t.boolean :default
      t.references :user, index: true
      t.references :address_type, index: true
	    t.references :city, index: true

      t.timestamps
    end
  end
end
