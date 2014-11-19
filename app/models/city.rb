class City < ActiveRecord::Base
  belongs_to :country
  has_many :addresses
  has_many :order_addresses
	
	
	
  def country_name
	  self.country.name
  end
	
end
