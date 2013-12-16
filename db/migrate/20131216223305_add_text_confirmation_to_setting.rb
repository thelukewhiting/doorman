class AddTextConfirmationToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :text_confirmation, :boolean
  end
end
