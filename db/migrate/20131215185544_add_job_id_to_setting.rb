class AddJobIdToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :job_id, :string
  end
end
