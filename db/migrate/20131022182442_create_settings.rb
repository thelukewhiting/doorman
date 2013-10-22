class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.belongs_to :user
      t.boolean :autounlock, :default => false

      t.timestamps
    end
  end
end
