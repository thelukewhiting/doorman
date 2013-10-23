class AddAccountSidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_sid, :string
  end
end
