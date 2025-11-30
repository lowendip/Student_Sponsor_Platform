class UserMailer < ActionMailer::Base
  #default :from => "sponsorstudentconfirm@gmail.com"
  default :from => "smailaccess@studentsponsorplatform.me"
  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Registration Confirmation")
  end
end
