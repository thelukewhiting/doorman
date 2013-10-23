class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def index

      if current_user.setting.autounlock
        @status = "enabled"
      else
        @status = "disabled"
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
    newsetting.recipient = params[:recipient]
      
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

    editsetting.update_attributes(params[:setting])

    redirect_to settings_path

  end

end