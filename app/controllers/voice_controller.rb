class VoiceController < ApplicationController

  def incoming

    @recipient = "+18286066498"
    @another_recipient = "+18285055600"
    @message = "The front gate was unlocked."
    
    #AccountSid is passed in as one of the parameters in the Twilio GET request.
    #We'll use this to look up the appropriate user and their settings

    user = User.find_by_account_sid(params[:AccountSid])

    @autounlock = user.setting.autounlock

    if @autounlock

      render action: "unlock.xml.builder", :layout => false

    else 

      render action: "forward.xml.builder", :layout => false

    end

  end

end