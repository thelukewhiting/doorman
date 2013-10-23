class AddRecipientToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :recipient, :string
  end
end
