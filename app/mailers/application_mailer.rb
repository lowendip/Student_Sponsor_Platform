class ApplicationMailer < ActionMailer::Base
  #For local application:
  #default from: "sponsorstudentconfirm@gmail.com"
  #For web application:
  default from: "mailaccess@studentsponsorplatform.me"
  
  layout "mailer"
end
