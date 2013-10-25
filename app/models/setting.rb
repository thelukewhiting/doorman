class Setting < ActiveRecord::Base

   belongs_to :user

   attr_accessible :user_id, :autounlock, :message, :recipient, :unlock_digits

   validates :user_id, presence: true, uniqueness: true

   validates :autounlock, :inclusion => { :in => [true, false] }

   validates :message, presence: true

   validates :unlock_digits, presence: true   

   validates_plausible_phone :recipient
   
end
