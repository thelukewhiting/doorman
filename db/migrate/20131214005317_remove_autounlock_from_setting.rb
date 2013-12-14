class RemoveAutounlockFromSetting < ActiveRecord::Migration
  def up
    remove_column :settings, :autounlock
  end

  def down
    add_column :settings, :autounlock, :boolean
  end
end
