class User < ActiveRecord::Base
  
  has_one :setting

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_sid
  # attr_accessible :title, :body

  validates :account_sid, length: { is: 34 } 

end
