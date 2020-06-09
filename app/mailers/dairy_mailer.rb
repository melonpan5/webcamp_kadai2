class DairyMailer < ApplicationMailer
	 def notify_user
        mail(bcc: User.pluck(:email), subject:"ご連絡")
    end
    #  def create_book
    #  	Book.create(user_id: 1, title: "タイトル" ,body: "BODY")
       
    # end
end

