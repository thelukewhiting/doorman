class VoiceController < ApplicationController

# before_filter :validate_params, except: [:settings_test]

  def incoming

    #AccountSid is passed in as one of the parameters in the Twilio GET request.
    #We'll use this to look up the appropriate settings

    setting = Setting.find_by_account_sid(params[:AccountSid])

    @unlock_digits = setting.unlock_digits

    @recipient = setting.recipient

    if params[:Digits]
      @pin = setting.pin

      if params[:Digits].to_i == @pin
        render 'pinunlock.xml.erb', content_type: 'text/xml', layout: false
      else
        render 'pinunlock_error.xml.erb', content_type: 'text/xml', layout: false
      end

    else

      mode = setting.mode

      case mode

      when 'manual'
        render 'manual.xml.erb', content_type: 'text/xml', layout: false

      when 'autounlock'
        render 'autounlock.xml.erb', content_type: 'text/xml', layout: false

      when 'pinunlock'
        if setting.pin == nil || setting.pin == ''
          render 'manual.xml.erb', content_type: 'text/xml', layout: false
        else
          render 'pincapture.xml.erb', content_type: 'text/xml', layout: false
        end

      when 'forward'
        @forward_nums = []
        @forward_nums << setting.forward1
        @forward_nums << setting.forward2
        @forward_nums << setting.forward3
        @forward_nums << setting.forward4

        render 'forward.xml.erb', content_type: 'text/xml', layout: false

      else
        render 'manual.xml.erb', content_type: 'text/xml', layout: false
      end

    end

  end

  def validate_params
    redirect_to dashboard_path unless params[:AccountSid]
  end

  def settings_test

    setting = Setting.find_by_account_sid(params[:AccountSid])

    @unlock_digits = setting.unlock_digits

    @recipient = setting.recipient

    render 'test.xml.erb', content_type: 'text/xml', layout: false

  end

end