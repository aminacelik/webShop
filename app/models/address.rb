class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :address_type
  belongs_to :city
	
	
	validates :street_name, :street_number, presence: true
	validates :user, associated: true
	validates :city, associated: true
	validates :address_type, associated: true
	
  def country_name
	  self.city.country_name
  end
  
  def street
#	  self.street_name + ', ' + self.street_number
	  "#{street_name}, #{street_number}"
  end
	
  def city_details
	  "#{city.postal_code}, #{city.name}"
  end
end
