class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def index

    if current_user.setting.autounlock
      @status = "enabled"
    else
      @status = "disabled"
    end

  end

  def update   

    user = User.find_by_id(params[:id])
    
    if params[:autounlock] == "false"

      user.setting.autounlock = false

    else
      
      user.setting.autounlock = true

    end    

    user.setting.save

    redirect_to settings_path

  end

end