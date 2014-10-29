class User < ActiveRecord::Base
  
  belongs_to :role
  has_many :addresses
	
  validates :name, :email, :role_id, presence: true
  validates :email, uniqueness: true
  validates :email, format: {
      with: %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i,
      message: 'Email address you entered is not valid.'
    }
  
  has_secure_password #validates if the pass and pass confirmation match
	

end
