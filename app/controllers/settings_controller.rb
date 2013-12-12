class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def new


  end

  def edit

    @setting = Setting.find_by_id(params[:id])

  end


  def create

    setting = Setting.where(user_id: current_user.id)

    newsetting.unlock_digits = params[:setting][:unlock_digits]
    newsetting.message = params[:setting][:message]

    # Uses phony_rails to normalize to the e164 format before saving
    newsetting.recipient = params[:setting][:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    newsetting.autounlock = params[:setting][:autounlock]

    newsetting.save

    redirect_to dashboard_path

  end


  def update

    editsetting = Setting.find_by_id(params[:id])

    # Uses phony_rails to normalize to the e164 format before updating
    params[:setting][:recipient] = params[:setting][:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')

    editsetting.update_attributes(params[:setting])

    redirect_to dashboard_path

  end

  def create_twilio_account

    parent_account_sid = ENV['TWILIO_ACCOUNT_SID']
    parent_auth_token = ENV['TWILIO_AUTH_TOKEN']

    client = Twilio::REST::Client.new(parent_account_sid, parent_auth_token)

    subaccount = client.accounts.create({:FriendlyName => current_user.email})

    new_setting = Setting.new
    new_setting.user_id = current_user.id
    new_setting.account_sid = subaccount.sid
    new_setting.twilio_auth_token = subaccount.auth_token

    new_setting.save

    success = true

    respond_to do |format|
      format.json {render :json => success}
    end

  end

  def fetch_twilio_number

    area_code = params[:area_code]

    setting = Setting.where(user_id: current_user.id)

    sub_account_client = Twilio::REST::Client.new(setting.account_sid, setting.auth_token)
    subaccount = sub_account_client.account
    numbers = subaccount.available_phone_numbers.get('US').local.list({:area_code => area_code})

    phone_numbers = []

    numbers.each do |num|
      phone_numbers << num.phone_number
    end

    respond_to do |format|
      format.json {render :json => phone_numbers}
    end

  end

  def buy_twilio_number

    twilio_number = params[:phone_number]

    setting = Setting.where(user_id: current_user.id)
    subaccount_client = Twilio::REST::Client.new(setting.account_sid, setting.auth_token)
    subaccount = sub_account_client.account

    subaccount.incoming_phone_numbers.create(:phone_number => twilio_number)

    setting = Setting.where(user_id: current_user.id)
    setting.twilio_number = twilio_number
    setting.save

    success = true

    respond_to do |format|
      format.json {render :json => success}
    end

  end

end