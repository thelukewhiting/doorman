class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def new

  end

  def edit

    @setting = Setting.find_by_id(params[:id])

  end


  def create

    # binding.pry

    # setting = Setting.where(user_id: current_user.id)

    # if params[:autounlock] == 'on'
      # autounlock = true
    # else
      # autounlock = false
    # end

    # # Uses phony_rails to normalize to the e164 format before saving
    # formatted_recipient = params[:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')

    # setting[0].update_attributes(unlock_digits: params[:unlock_digits], message: params[:message], recipient: formatted_recipient, autounlock: autounlock )

    success = true

    respond_to do |format|
      format.json {render :json => success}
    end

  end


  def update

    editsetting = Setting.find_by_id(params[:id])

    # Uses phony_rails to normalize to the e164 format before updating
    params[:setting][:recipient] = params[:setting][:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')

    editsetting.update_attributes(params[:setting])

    redirect_to dashboard_path

  end

  def create_twilio_account

    # parent_account_sid = ENV['TWILIO_ACCOUNT_SID']
    # parent_auth_token = ENV['TWILIO_AUTH_TOKEN']

    sleep 1

    # client = Twilio::REST::Client.new(parent_account_sid, parent_auth_token)

    # subaccount = client.accounts.create({:FriendlyName => current_user.email, :VoiceURL => 'http://doormanapp.herokuapp.com/voice/incoming', :VoiceMethod => 'GET'})

    # new_setting = Setting.new
    # new_setting.user_id = current_user.id
    # new_setting.account_sid = subaccount.sid
    # new_setting.twilio_auth_token = subaccount.auth_token

    # new_setting.save

    success = true

    respond_to do |format|
      format.json {render :json => success}
    end

  end

  def fetch_twilio_number

    area_code = params[:area_code]

    # setting = Setting.where(user_id: current_user.id)

    # account_sid = setting[0].account_sid
    # twilio_auth_token = setting[0].twilio_auth_token

    # Using primary account SID & auth token for testing (comment out for production)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_auth_token = ENV['TWILIO_AUTH_TOKEN']

    sub_account_client = Twilio::REST::Client.new(account_sid, twilio_auth_token)
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

    sleep 0.5

    # setting = Setting.where(user_id: current_user.id)

    # account_sid = setting[0].account_sid
    # twilio_auth_token = setting[0].twilio_auth_token

    # sub_account_client = Twilio::REST::Client.new(account_sid, twilio_auth_token)
    # subaccount = sub_account_client.account

    # subaccount.incoming_phone_numbers.create(:phone_number => twilio_number)

    # setting = Setting.where(user_id: current_user.id)
    # setting[0].update_attributes(twilio_number: twilio_number)

    success_number = {twilio_number: twilio_number}

    respond_to do |format|
      format.json {render :json => success_number}
    end

  end

  def test_settings

    setting = Setting.where(user_id: current_user.id)

    account_sid = setting[0].account_sid
    twilio_auth_token = setting[0].twilio_auth_token
    twilio_number = setting[0].twilio_number
    recipient = setting[0].recipient

    twilio_client = Twilio::REST::Client.new account_sid, twilio_auth_token

    call = twilio_client.account.calls.create(
      :from => twilio_number,
      :to => recipient,
      :url => 'https://lukewhiting.fwd.wf/voice/settings_test',
    )

    success = true

    respond_to do |format|
      format.json {render :json => success}
    end

  end

end