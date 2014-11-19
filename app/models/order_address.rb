class OrderAddress < ActiveRecord::Base
  belongs_to :user
  belongs_to :city

  def country_name
	self.city.country_name
  end
  
  def street
	  "#{street_name}, #{street_number}"
  end
	
  def city_details
	  "#{city.postal_code}, #{city.name}"
  end

  def print_format
    "#{street} \n #{city_details} \n #{country_name}"
  end
end
