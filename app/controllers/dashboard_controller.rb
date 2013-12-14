class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index



    user = current_user.setting

    if user
      @unlock_digits = user.unlock_digits
      @message = user.message
      @recipient = user.recipient


      end

    else
      @unlock_digits = "Unlock digits not set"
      @message = "Unlock message not set"
      @recipient = "SMS recipient not set"

    end

  end

end
