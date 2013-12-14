class AddCountdownToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :countdown, :string
  end
end
