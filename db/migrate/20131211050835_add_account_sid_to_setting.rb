class AddAccountSidToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :account_sid, :string
  end
end
