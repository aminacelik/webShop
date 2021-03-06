class User < ActiveRecord::Base
  
  belongs_to :role
  has_many :addresses
	
  validates :name, presence: true, uniqueness: true
  validates :role_id, presence: true
  has_secure_password #validates if the pass and pass confirmation match
	

end
