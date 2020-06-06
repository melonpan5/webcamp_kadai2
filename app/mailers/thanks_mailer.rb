class ThanksMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.thanks_mailer.user_thanks_mail.subject
  #
 
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
  def confirmation_instructions(record, token, opts={})
    #record内にユーザ情報が入っていました。そこの"unconfirmed_email"の有無で登録／変更を仕分けます
    #opts属性を上書きすることで、Subjectやfromなどのヘッダー情報を変更することが可能！
    if record.unconfirmed_email != nil
      opts[:subject] = "【●●●アプリ】メールアドレス変更手続きを完了してください"
    else
      opts[:subject] = "【●●●アプリ】会員登録完了"
    end
    #件名の指定以外は親を継承
    super
  end

end
