class AddressType < ActiveRecord::Base
	# has_many :addresses
	validates :name, presence: true
end
