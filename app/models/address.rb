class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :address_type
  belongs_to :city
end
