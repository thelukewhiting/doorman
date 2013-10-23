class SettingsController < ApplicationController

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

  def new 

  end

  def edit

    @setting = Setting.find_by_id(params[:id])

  end


  def create

    newsetting = Setting.new
    newsetting.user_id = current_user.id
    newsetting.message = params[:message] 
    
    # Uses phony_rails to normalize to the e164 format before saving
    newsetting.recipient = params[:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
      
      if(params.has_key?(:autounlock))
        newsetting.autounlock = true
      else
        newsetting.autounlock = false
      end

    newsetting.save
    
    redirect_to settings_path

  end


  def update   

    editsetting = Setting.find_by_id(params[:id])

    # Uses phony_rails to normalize to the e164 format before updating
    params[:setting][:recipient] = params[:setting][:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')

    editsetting.update_attributes(params[:setting])

    redirect_to settings_path

  end

end