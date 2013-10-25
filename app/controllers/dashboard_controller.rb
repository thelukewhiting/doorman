class DashboardController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    if current_user.setting != nil

      @message = current_user.setting.message

      @recipient = current_user.setting.recipient

      if current_user.setting.autounlock
        @status = "enabled"
      else
        @status = "disabled"
      end

    else  

      @message = "Not set"
      @recipient = "Not set"
      @status = "Not set"

    end

  end

end
