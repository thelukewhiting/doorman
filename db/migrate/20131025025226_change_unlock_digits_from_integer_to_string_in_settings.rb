class ChangeUnlockDigitsFromIntegerToStringInSettings < ActiveRecord::Migration
  def up
    change_column :settings, :unlock_digits, :string
  end

  def down
    change_column :settings, :unlock_digits, :integer
  end
end
