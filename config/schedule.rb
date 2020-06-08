# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# 絶対パスから相対パス指定
# env :PATH, ENV['PATH']
# sanoshi : rails_env = ENV['RAILS_ENV'] ||= 'development'
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development

set :output, error: 'log/crontab_error.log', standard: 'log/crontab.log'
set :environment, rails_env
ENV.each { |k, v| env(k, v) } # これを追加
# ログファイルの出力先
set :output, 'log/cron.log'
# ジョブの実行環境の指定
set :environment, :development
# PATH add
env :PATH, ENV['PATH']

# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end

# every 1.days, at: '9:00 am' do
every 1.minutes do
#
# Rails内のメソッド実行
 runner "DairyMailer.notify_user"
 runner "DairyMailer.create_book"
end

# Learn more: http://github.com/javan/whenever
