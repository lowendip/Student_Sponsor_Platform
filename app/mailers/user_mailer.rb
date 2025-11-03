class UserMailer < ActionMailer::Base
  default :from => "sponsorstudentconfirm@gmail.com"

  def registration_confirmation(user)
    @user = user
    #mail(:to => @user.email, :subject => "Registration Confirmation") #Temporarily disabled due to issues with heroku
  end
end
