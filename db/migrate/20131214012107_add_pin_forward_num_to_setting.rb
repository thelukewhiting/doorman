class AddPinForwardNumToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :pin, :integer
    add_column :settings, :forward1, :string
    add_column :settings, :forward2, :string
    add_column :settings, :forward3, :string
    add_column :settings, :forward4, :string
  end
end
