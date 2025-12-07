class ApplicationMailer < ActionMailer::Base
  #Main email:
  default from: "sponsorstudentconfirm@gmail.com"
  #Alternative email:
  #default from: "mailaccess@studentsponsorplatform.me"
  
  layout "mailer"
end
