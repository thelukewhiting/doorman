class AddUnlockDigitsToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :unlock_digits, :integer
  end
end
