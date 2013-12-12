class AddTwilioNumberToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :twilio_number, :string
  end
end
