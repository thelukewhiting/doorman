class AddTwilioAuthTokenToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :twilio_auth_token, :string
  end
end
