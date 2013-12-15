class AutounlockWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform(current_user_id)

    setting = Setting.where(user_id: current_user_id)

    if setting[0].job_id == jid && setting[0].countdown != nil
      setting[0].update_attributes(mode: "manual", countdown: nil, job_id: nil)
    end

  end

end