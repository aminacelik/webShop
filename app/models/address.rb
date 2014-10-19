class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :address_type
  belongs_to :city
	
	
  def country_name
	  self.city.country_name
  end
  
  def street
#	  self.street_name + ', ' + self.street_number
	  "#{street_name}, #{street_number}"
  end
end
