class Setting < ActiveRecord::Base

   belongs_to :user

   attr_accessible :user_id, :recipient, :unlock_digits, :account_sid, :twilio_number, :countdown, :mode, :pin, :forward1, :forward2, :forward3, :forward4, :job_id, :text_confirmation

   # validates :user_id, presence: true, uniqueness: true

   # validates :autounlock, :inclusion => { :in => [true, false] }

   # validates :message, presence: true

   # validates :unlock_digits, presence: true

   # validates_plausible_phone :recipient

   # validates :account_sid, length: { is: 34 }, uniqueness: true

end
