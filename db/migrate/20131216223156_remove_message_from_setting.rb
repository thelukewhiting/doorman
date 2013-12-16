class RemoveMessageFromSetting < ActiveRecord::Migration
  def up
    remove_column :settings, :message
  end

  def down
    add_column :settings, :message, :string
  end
end
