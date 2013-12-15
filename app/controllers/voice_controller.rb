class VoiceController < ApplicationController

# before_filter :validate_params, except: [:settings_test]


  def incoming

    #AccountSid is passed in as one of the parameters in the Twilio GET request.
    #We'll use this to look up the appropriate settings

    setting = Setting.find_by_account_sid(params[:AccountSid])

    @unlock_digits = setting.unlock_digits

    @recipient = setting.recipient

    @message = setting.message

    mode = setting.mode

    case mode

    when 'manual'
      render 'manual.xml.erb', content_type: 'text/xml', layout: false

    when 'autounlock'
      render 'autounlock.xml.erb', content_type: 'text/xml', layout: false

    when 'pinunlock'
      render 'pinunlock.xml.erb', content_type: 'text/xml', layout: false

    when 'forward'
      render 'forward.xml.erb', content_type: 'text/xml', layout: false

    else
      render 'manual.xml.erb', content_type: 'text/xml', layout: false
    end

  end

  def validate_params
    redirect_to dashboard_path unless params[:AccountSid]
  end

  def settings_test

    setting = Setting.find_by_account_sid(params[:AccountSid])

    @unlock_digits = setting.unlock_digits

    @recipient = setting.recipient

    @message = setting.message

    render 'test.xml.erb', content_type: 'text/xml', layout: false

  end

end