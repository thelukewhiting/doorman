class AddMessageToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :message, :string
  end
end
