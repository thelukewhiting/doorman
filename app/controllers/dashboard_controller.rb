class DashboardController < ApplicationController

  before_filter :authenticate_user!

  require 'action_view'

  include ActionView::Helpers::DateHelper

  def index

    setting = current_user.setting

    if setting.mode == 'manual'
      render 'manual.html.erb'

    elsif setting.mode == 'autounlock' && setting.countdown == nil
      render 'autounlock.html.erb'

    elsif setting.countdown

      from_time = Time.now.utc
      to_time = setting.countdown

      @countdown = distance_of_time_in_words(from_time, to_time, include_seconds: true)

      render 'autounlock_timer.html.erb'

    elsif setting.mode == 'pinunlock'
      render 'pin.html.erb'

    elsif setting.mode == 'forward'
      render 'forward.html.erb'

    else
      render 'no_setting.html.erb'
    end

  end

end
