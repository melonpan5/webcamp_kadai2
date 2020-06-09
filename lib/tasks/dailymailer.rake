namespace :dailymailer do
  desc 'Run tests'
  task sample: :environment do
    DairyMailer.notify_user.deliver_now
  end
end
