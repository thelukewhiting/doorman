class RemoveAccountSidFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :account_sid
  end

  def down
    add_column :users, :account_sid, :string
  end
end
