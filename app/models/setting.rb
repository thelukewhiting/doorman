class Setting < ActiveRecord::Base
   
   belongs_to :user

   attr_accessible :user_id, :autounlock, :message, :recipient

   validates :autounlock, :inclusion => { :in => [true, false] }

   validates :user_id, presence: true, uniqueness: true

end
