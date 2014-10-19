class City < ActiveRecord::Base
  belongs_to :country
  has_many :addresses, dependent: :destroy
	
	
	
  def country_name
	  self.country.name
  end
	
end
