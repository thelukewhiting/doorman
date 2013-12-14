class AddModeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :mode, :string
  end
end
