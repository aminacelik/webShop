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
	


  def has_billing_address?
    addresses.where(billing: true).present?
  end
    
  def the_same_billling_and_shipping_address?
    addresses.where(billing: true, shipping_default: true).first.present?
  end

  def billing_address
    addresses.where(billing: true).first
  end
    
  def default_shipping_address
    addresses.where(shipping_default: true).first
  end


end
