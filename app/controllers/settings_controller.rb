class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def new 

    @setting = Setting.new

  end

  def edit

    @setting = Setting.find_by_id(params[:id])

  end


  def create    

    newsetting = Setting.new
    
    newsetting.user_id = current_user.id
    newsetting.message = params[:setting][:message] 
    newsetting.autounlock = params[:setting][:autounlock]
    # Uses phony_rails to normalize to the e164 format before saving
    newsetting.recipient = params[:setting][:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
      
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