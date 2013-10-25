class DashboardController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    if current_user.setting != nil

      @unlock_digits = current_user.setting.unlock_digits
      
      @message = current_user.setting.message

      @recipient = current_user.setting.recipient

      if current_user.setting.autounlock
        @status = "Enabled"
      else
        @status = "Disabled"
      end

    else  

      @unlock_digits = "Unlock digits not set"
      @message = "Unlock message not set"
      @recipient = "SMS recipient not set"
      @status = "Autounlock not set"

    end

  end

end
