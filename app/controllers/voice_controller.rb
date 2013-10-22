class VoiceController < ApplicationController

  def index
    
    @newsetting = Setting.create(user_id: current_user.id, autounlock: true)
    @allsettings = Setting.all

  end

  def incoming
    @recipient = "+18286066498"
    @message = "The front gate was unlocked."
    @autounlock = current_user.setting.autounlock

    if @autounlock

      render action: "unlock.xml.builder", :layout => false

    else 

      render action: "forward.xml.builder", :layout => false

    end

  end

end









