class VoiceController < ApplicationController

before_filter :validate_params

  def incoming

    #AccountSid is passed in as one of the parameters in the Twilio GET request.
    #We'll use this to look up the appropriate settings

    setting = Setting.find_by_account_sid(params[:AccountSid])

    @unlock_digits = setting.unlock_digits

    @recipient = setting.recipient

    @message = setting.message

    @autounlock = setting.autounlock

    if @autounlock

      # render action: "unlock.xml.builder", :layout => false
      render 'unlock.xml.erb', content_type: 'text/xml', layout: false

    else

      # render action: "forward.xml.builder", :layout => false
      render 'forward.xml.erb', content_type: 'text/xml', layout: false

    end

  end

  def validate_params
    redirect_to dashboard_path unless params[:AccountSid]
  end

end