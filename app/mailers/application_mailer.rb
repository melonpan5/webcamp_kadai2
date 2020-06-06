class ApplicationMailer < ActionMailer::Base
  default from:     "メールテスト運営局",
          reply_to: "hoshi2771@gmail.com"
  layout 'mailer'
