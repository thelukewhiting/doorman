class SettingsController < ApplicationController

  before_filter :authenticate_user!

  require 'action_view'

  include ActionView::Helpers::DateHelper

  def new

    setting = current_user.setting

    if setting

      if setting.account_sid && setting.twilio_number == nil
        render 'area_code.html.erb'
      elsif setting.account_sid && setting.twilio_number && setting.recipient == nil
        render 'other_settings.html.erb'
      else
        redirect_to action: "edit", id: current_user.setting.id
      end

    else
      render 'new.html.erb'
    end

  end

  def edit

    @setting = Setting.find_by_id(params[:id])

  end


  def create

    setting = Setting.where(user_id: current_user.id)

    # Uses phony_rails to normalize to the e164 format before saving
    params[:recipient] = params[:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')

    if params[:forward1] != ''
      params[:forward1] = params[:forward1].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    end

    if params[:forward2] != ''
      params[:forward2] = params[:forward2].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    end

    if params[:forward3] != ''
      params[:forward3] = params[:forward3].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    end

    if params[:forward4] != ''
      params[:forward4] = params[:forward4].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    end

    setting[0].update_attributes(unlock_digits: params[:unlock_digits], recipient: params[:recipient], text_confirmation: params[:text_confirmation], pin: params[:pin], forward1: params[:forward1], forward2: params[:forward2], forward3: params[:forward3], forward4: params[:forward4], mode: "manual")
    success = true

    respond_to do |format|
      format.json {render :json => success}
    end

  end


  def update

    editsetting = Setting.find_by_id(params[:id])

    # Uses phony_rails to normalize to the e164 format before updating
    params[:setting][:recipient] = params[:setting][:recipient].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')

    if params[:setting][:forward1] != ''
      params[:setting][:forward1] = params[:setting][:forward1].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    end

    if params[:setting][:forward2] != ''
      params[:setting][:forward2] = params[:setting][:forward2].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    end

    if params[:setting][:forward3] != ''
      params[:setting][:forward3] = params[:setting][:forward3].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    end

    if params[:setting][:forward4] != ''
      params[:setting][:forward4] = params[:setting][:forward4].phony_formatted!(:normalize => 'US', :format => :international, :spaces => '')
    end

    editsetting.update_attributes(params[:setting])

    redirect_to dashboard_path

  end

  def create_twilio_account

    parent_account_sid = ENV['TWILIO_ACCOUNT_SID']
    parent_auth_token = ENV['TWILIO_AUTH_TOKEN']

    client = Twilio::REST::Client.new(parent_account_sid, parent_auth_token)

    subaccount = client.accounts.create({:FriendlyName => current_user.email, :VoiceUrl => 'http://doormanapp.herokuapp.com/voice/incoming', :VoiceMethod => 'POST'})

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

    account_sid = setting[0].account_sid
    twilio_auth_token = setting[0].twilio_auth_token

    # Using primary account SID & auth token for testing (comment out for production)
    # account_sid = ENV['TWILIO_ACCOUNT_SID']
    # twilio_auth_token = ENV['TWILIO_AUTH_TOKEN']

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

    setting = Setting.where(user_id: current_user.id)

    account_sid = setting[0].account_sid
    twilio_auth_token = setting[0].twilio_auth_token

    sub_account_client = Twilio::REST::Client.new(account_sid, twilio_auth_token)
    subaccount = sub_account_client.account

    subaccount.incoming_phone_numbers.create(:phone_number => twilio_number)

    setting = Setting.where(user_id: current_user.id)
    setting[0].update_attributes(twilio_number: twilio_number)

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

  def start_timer

    setting = Setting.where(user_id: current_user.id)

    seconds = params[:seconds].to_i

    status = false

    if setting[0].countdown == nil

      job_time = Time.now.utc + seconds

      job_id = AutounlockWorker.perform_at(job_time, current_user.id)

      setting[0].update_attributes(countdown: job_time, job_id: job_id)

      countdown = {countdown: (distance_of_time_in_words(Time.now.utc, job_time, include_seconds: true))}

      status = countdown

    end

    respond_to do |format|
      format.json {render :json => status}
    end

  end

  def update_mode

    setting = Setting.where(user_id: current_user.id)

    setting[0].update_attributes(mode: params[:mode])

    if setting[0].job_id != nil && setting[0].countdown != nil

      setting[0].update_attributes(countdown: nil, job_id: nil, mode: params[:mode])
    else
      setting[0].update_attributes(mode: params[:mode])
    end

    respond_to do |format|
      format.json {render :json => setting}
    end
  end

end