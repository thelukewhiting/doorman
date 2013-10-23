class VoiceController < ApplicationController

  def incoming

    #AccountSid is passed in as one of the parameters in the Twilio GET request.
    #We'll use this to look up the appropriate user and their settings

    user = User.find_by_account_sid(params[:AccountSid])

    @recipient = user.setting.recipient

    @message = user.setting.message

    @autounlock = user.setting.autounlock   

    if @autounlock

      render action: "unlock.xml.builder", :layout => false

    else 

      render action: "forward.xml.builder", :layout => false

    end

  end

end