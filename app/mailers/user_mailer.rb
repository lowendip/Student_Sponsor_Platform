class UserMailer < ActionMailer::Base
  #Main email:
  default from: "sponsorstudentconfirm@gmail.com"
  #Alternative email:
  #default :from => "mailaccess@studentsponsorplatform.me"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Registration Confirmation")
  end
  
  def password_reset
    @user = params[:user]
    @password_reset_token = params[:password_reset_token]
    mail(:to => @user.email, :subject => "Password Reset")
  end
end
